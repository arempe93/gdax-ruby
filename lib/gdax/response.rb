# frozen_string_literal: true

module GDAX
  ##
  # GDAX::Response is a wrapper around a Faraday::Response
  #
  class Response
    # Error for invalid response bodies
    InvalidResponseError = Class.new(APIError)

    class << self
      ##
      # Build GDAX::Response from a Faraday::Response object
      #
      # @api private
      #
      def from_faraday(response)
        new(response.body, response.headers, response.status)
      end

      ##
      # Build GDAX::Response from a hash containing response data
      #
      # @api private
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

    ##
    # Initializes a GDAX::Response object
    #
    # @param [String] body Response body
    # @param [Hash] headers Response headers
    # @param [Integer] status Reponse status
    #
    # @api private
    #
    def initialize(body, headers, status)
      @body = body
      @headers = headers
      @status = status
      @data = JSON.parse(body, symbolize_names: true)
    rescue JSON::ParserError
      raise InvalidResponseError.new("Invalid response: #{body}", response: self)
    end

    ##
    # Get data from the JSON response by key
    #
    # @param [Symbol] key JSON key of data
    #
    # @api public
    #
    def [](key)
      @data[key]
    end

    def inspect
      "#<GDAX::Response @status=#{@status} #{self}>"
    end

    def to_s
      @data.to_s
    end
  end
end
