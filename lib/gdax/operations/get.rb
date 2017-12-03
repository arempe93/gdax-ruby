# frozen_string_literal: true

module GDAX
  module Operations
    module Get
      module ClassMethods
        def retrieve(params = {})
          new(params).reload
        end
      end

      def self.included(base)
        base.prepend(self)
        base.extend(ClassMethods)
      end

      attr_reader :id

      def initialize(params = {})
        super(params)
        @id = @params.delete(:id)
      end

      #
      # Reload data from the api
      #
      def reload(params = nil)
        @params = params if params
        response = Client.current.get(resource_url, @params)
        load(response.data)
      end

      #
      # Get relative path of this resource instance
      #
      def resource_url
        "#{self.class.resource_url}/#{CGI.escape(id)}"
      end
    end
  end
end
