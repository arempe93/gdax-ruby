# frozen_string_literal: true

module GDAX
  module Operations
    module Get
      module ClassMethods
        ##
        # Get a resource from the api
        #
        # @param [Hash] params Request parameters
        #
        # @return [GDAX::Resource] Resource fetched
        # @api public
        #
        def retrieve(params = {})
          new(params).reload
        end
      end

      # @api private
      def self.included(base)
        # NOTE: prepend to correctly override initialize on receiver
        base.prepend(self)
        base.extend(ClassMethods)
      end

      # ID of the resource
      attr_reader :id

      # @api private
      def initialize(params = {})
        super(params)
        @id = @params.delete(:id)
      end

      ##
      # Reload this resource with data from the api
      #
      # @param [Hash] params Request parameters
      #
      # @return [GDAX::Resource] Reloaded resource
      # @api public
      #
      def reload(params = nil)
        @params = params if params
        response = Client.current.get(resource_url, @params)
        load(response.data)
      end

      # @api private
      def resource_url
        "#{self.class.resource_url}/#{CGI.escape(id)}"
      end
    end
  end
end
