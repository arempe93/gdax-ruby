# frozen_string_literal: true

module GDAX
  module Operations
    module Create
      module ClassMethods
        ##
        # Create a new resource with a POST to the api
        #
        # @param [Hash] params Request parameters
        #
        # @return [GDAX::Resource] Resource created
        # @api public
        #
        def create(params)
          response = Client.current.post(resource_url, params)
          new(id: response[:id]).load(response.data)
        end
      end

      # @api private
      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
