# frozen_string_literal: true

module GDAX
  class Client
    ConfigError = Class.new(StandardError)

    USER_AGENT = "Faraday v#{Faraday::VERSION}; gdax-ruby v#{VERSION}"

    attr_accessor :conn

    class << self
      def current
        Thread.current[:gdax_client] || default_client
      end

      def default_client
        Thread.current[:gdax_default_client] ||= Client.new(default_conn)
      end

      def default_conn
        Thread.current[:gdax_default_conn] ||= Faraday.new do |c|
          c.use Faraday::Request::UrlEncoded
          c.use Faraday::Response::RaiseError
          c.adapter Faraday.default_adapter
          c.headers = { 'Content-Type' => 'application/json', 'User-Agent' => USER_AGENT }
        end
      end
    end

    def initialize(conn = nil)
      self.conn = conn || self.class.default_conn
    end

    def request(method, path, params: {}, headers: {})
      check_authentication_config!

      url = URL.new("#{GDAX.api_base}#{path}")
      requested_at = Time.now.to_i.to_s

      body = case method
             when :get, :head, :delete
               nil.tap { url.add_params!(params) }
             else
               params.to_json
             end

      headers['CB-ACCESS-KEY'] = GDAX.api_key
      headers['CB-ACCESS-TIMESTAMP'] = requested_at
      headers['CB-ACCESS-PASSPHRASE'] = GDAX.api_passphrase
      headers['CB-ACCESS-SIGN'] = sign("#{requested_at}#{method.upcase}#{path}#{body}")

      execute_with_rescues { conn.run_request(method, url.to_s, body, headers) }
    end

    def execute_with_rescues
      faraday_response = yield
      Response.new(faraday_response)
    rescue Faraday::ClientError => e
      p 'client error'
    rescue StandardError => e
      p 'standard error'
    end

    def sign(message)
      secret = Base64.decode64(GDAX.api_secret)
      hash = OpenSSL::HMAC.digest('sha256', secret, message)
      Base64.strict_encode64(hash)
    end

    private

    def check_authentication_config!
      %i[api_key api_secret api_passphrase].each do |key|
        raise ConfigError, "#{key} is missing, set with GDAX.#{key}=" unless GDAX.config[key]
      end
    end
  end
end
