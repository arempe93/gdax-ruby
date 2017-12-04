# frozen_string_literal: true

module GDAX
  ##
  # Client to access GDAX REST API
  #
  class Client
    include Client::Verbs

    # Error for missing configurations
    ConfigError = Class.new(Error)

    # Custom user agent on all requests
    USER_AGENT = "Faraday v#{Faraday::VERSION}; gdax-ruby v#{VERSION}"

    # Faraday connection
    attr_accessor :conn

    class << self
      ##
      # Get current client for thread
      #
      # @return [GDAX::Client] Client instance
      # @api public
      #
      def current
        Thread.current[:gdax_client] || default_client
      end

      ##
      # Create a default Faraday connection for thread
      #
      # @return [Faraday::Connection] Faraday connection
      # @api public
      #
      def default_conn
        Thread.current[:gdax_default_conn] ||= Faraday.new do |c|
          c.use Faraday::Request::UrlEncoded
          c.use Faraday::Response::RaiseError
          c.adapter Faraday.default_adapter
          c.headers = { 'Content-Type' => 'application/json', 'User-Agent' => USER_AGENT }
        end
      end

      private

      ##
      # Create a default client for thread
      #
      # @return [GDAX::Client] Client instance with default connection
      # @api private
      #
      def default_client
        Thread.current[:gdax_default_client] ||= Client.new(default_conn)
      end
    end

    ##
    # Create a new Client with Faraday::Connection
    #
    # @param [Faraday::Connection,Nil] A Faraday connection to use, defaults to ::default_conn
    #
    # @api public
    #
    def initialize(conn = nil)
      self.conn = conn || self.class.default_conn
    end

    private

    ##
    # Executes a request to the GDAX api
    #
    # @return [GDAX::Response] Response
    # @api private
    #
    def request(method, url, body = nil, public = false)
      check_access_config! unless public

      headers = access_headers(method, url, body) unless public

      execute_with_rescues { conn.run_request(method, url.to_s, body, headers) }
    end

    ##
    # Create all GDAX API required access headers
    #
    # @param [Symbol] method HTTP verb
    # @param [GDAX::URL] url URL representing the request
    # @param [String,Nil] body JSON body of the request
    #
    # @return [Hash] CB-ACCESS headers
    # @api private
    #
    def access_headers(method, url, body)
      requested_at = timestamp

      {
        'CB-ACCESS-KEY' => GDAX.api_key,
        'CB-ACCESS-TIMESTAMP' => requested_at,
        'CB-ACCESS-PASSPHRASE' => GDAX.api_passphrase,
        'CB-ACCESS-SIGN' => sign("#{requested_at}#{method.upcase}#{url.path_with_query}#{body}")
      }
    end

    ##
    # Executes request in block with rescues
    #
    # @return [GDAX::Response] Response
    # @api private
    #
    def execute_with_rescues
      Response.from_faraday(yield)
    rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
      raise ConnectionError, e.message
    rescue Faraday::ClientError => e
      response = Response.from_hash(e.response)
      raise APIError.new(response[:message], response: response)
    end

    ##
    # Sign a message with the api secret, using HMAC SHA256
    #
    # @param [String] message Message to be signed
    #
    # @return [String] Signature
    # @api private
    #
    def sign(message)
      secret = Base64.decode64(GDAX.api_secret)
      hash = OpenSSL::HMAC.digest('sha256', secret, message)
      Base64.strict_encode64(hash)
    end

    ##
    # Gets the system time or requests /time, depending on GDAX.use_server_time
    #
    # @return [String] String representing a timestamp that can be used by GDAX
    # @api private
    #
    def timestamp
      GDAX.use_server_time ? get('/time', {}, true)[:epoch] : Time.now.to_i.to_s
    end

    ##
    # Ensure all access config options are set
    #
    # @api private
    #
    def check_access_config!
      %i[api_key api_secret api_passphrase].each do |key|
        raise ConfigError, "#{key} is missing, set with GDAX.#{key}=" unless GDAX.config[key]
      end
    end
  end
end
