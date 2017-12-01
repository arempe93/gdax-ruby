# frozen_string_literal: true

module GDAX
  class Response
    attr_reader :http_body

    attr_reader :http_headers

    attr_reader :http_status

    attr_reader :data

    def initialize(response)
      @http_body = response.body
      @http_headers = response.headers
      @http_status = response.status
      @data = JSON.parse(@http_body, symbolize_names: true)
    end

    def [](key)
      @data[key]
    end
  end
end
