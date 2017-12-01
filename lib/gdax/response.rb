# frozen_string_literal: true

module GDAX
  #
  # GDAX::Response is a wrapper around a Faraday::Response
  #
  class Response
    # Error for invalid response bodies
    InvalidResponseError = Class.new(Error)

    class << self
      #
      # Build GDAX::Response from a Faraday::Response object
      #
      def from_faraday(response)
        new(response.body, response.headers, response.status)
      end

      #
      # Build GDAX::Response from a hash containing response data
      #
      def from_hash(hash)
        new(hash[:body], hash[:headers], hash[:status])
      end
    end

    # Raw body of the HTTP response
    attr_reader :body

    # Hash containing headers of the HTTP response
    attr_reader :headers

    # Integer status of the HTTP response
    attr_reader :status

    # JSON parsed body, with symbol keys
    attr_reader :data

    #
    # Initializes a GDAX::Response object from a Faraday::Response object
    #
    def initialize(body, headers, status)
      @body = body
      @headers = headers
      @status = status
      @data = JSON.parse(body, symbolize_names: true)
    rescue JSON::ParserError => e
      raise InvalidResponseError.new("Invalid response: #{body}", response: self)
    end

    #
    # Get data from the JSON response by key
    #
    def [](key)
      @data[key]
    end

    #
    # Show object info, with data
    #
    def inspect
      "#<GDAX::Response @status=#{@status} #{to_s}>"
    end

    #
    # Dump data hash as string
    #
    def to_s
      @data.to_s
    end
  end
end
