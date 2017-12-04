# frozen_string_literal: true

module GDAX
  class Client
    module Verbs
      ##
      # Initiate a DELETE request to the api
      #
      # @param [String] path Request path
      # @param [Hash] params Request parameters
      #
      # @return [GDAX::Response] Response from api
      # @api public
      #
      def delete(path, params = {})
        url = URL.new(path, params)
        request(:delete, url, nil)
      end

      ##
      # Initiate a DELETE request to the api
      #
      # @param [String] path Request path
      # @param [Hash] params Request parameters
      #
      # @return [GDAX::Response] Response from api
      # @api public
      #
      def get(path, params = {}, public = false)
        url = URL.new(path, params)
        request(:get, url, nil, public)
      end

      ##
      # Initiate a POST request to the api
      #
      # @param [String] path Request path
      # @param [Hash] body Request body
      #
      # @return [GDAX::Response] Response from api
      # @api public
      #
      def post(path, body = {})
        url = URL.new(path)
        request(:post, url, body.to_json)
      end
    end
  end
end
