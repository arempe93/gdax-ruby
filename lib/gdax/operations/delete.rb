# frozen_string_literal: true

module GDAX
  module Operations
    module Delete
      module ClassMethods
        ##
        # Delete a resource from the api
        #
        # @param [String] id Resource id
        #
        # @return [GDAX::Response] Response from api
        # @api public
        #
        def delete(id)
          new(id: id).delete
        end
      end

      # @api private
      def self.included(base)
        base.extend(ClassMethods)
      end

      ##
      # Delete this resource from the api
      #
      # @param [Hash] params Request parameters
      #
      # @return [GDAX::Response] Response from api
      # @api public
      #
      def delete(params = {})
        Client.current.delete(resource_url, params)
      end
    end
  end
end
