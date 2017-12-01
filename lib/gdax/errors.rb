# frozen_string_literal: true

module GDAX
  Error = Class.new(StandardError)

  class APIError < Error
    # Error message
    attr_reader :message

    # GDAX::Response object that relayed the error
    attr_reader :response

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

  ConnectionError = Class.new(APIError)
end
