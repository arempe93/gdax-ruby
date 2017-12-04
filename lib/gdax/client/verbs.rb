# frozen_string_literal: true

module GDAX
  class Client
    module Verbs
      def delete(path, params = {})
        url = URL.new(path, params)
        request(:delete, url, nil)
      end

      def get(path, params = {}, public = false)
        url = URL.new(path, params)
        request(:get, url, nil, public)
      end

      def post(path, params = {})
        url = URL.new(path)
        request(:post, url, params.to_json)
      end
    end
  end
end
