# frozen_string_literal: true

module GDAX
  Error = Class.new(StandardError)

  ##
  # An APIError is the result of a problem with a response from the GDAX API
  #
  class APIError < Error
    # Error message
    attr_reader :message

    # GDAX::Response object that relayed the error
    attr_reader :response

    ##
    # Create an APIError instance
    #
    # @param [String] message Error message
    # @param [GDAX::Response] response Response that relayed the error
    #
    # @api private
    #
    def initialize(message = '', response: nil)
      @message = message
      @response = response
    end

    def to_s
      if response
        "[#{response.status}] #{message}"
      else
        message
      end
    end
  end

  ##
  # A ConnectionError is a result of being unable to open a connection to GDAX
  #
  ConnectionError = Class.new(Error)
end
