# frozen_string_literal: true

module GDAX
  class Object < Resource
    attr_reader :id

    def initialize(params = {})
      super(params)
      @id = @params.delete(:id)
    end

    #
    # Get relative path of this resource instance
    #
    def resource_url
      "#{self.class.resource_url}/#{CGI.escape(id)}"
    end
  end
end
