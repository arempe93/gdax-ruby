# frozen_string_literal: true

module GDAX
  module Operations
    module List
      module ClassMethods
        ##
        # Create a collection of resources from api
        #
        # @param [Hash] params Request parameters
        #
        # @return [GDAX::Collection] Collection of Resources fetched
        # @api public
        #
        def list(params = {})
          Collection.new(self, params).reload
        end
      end

      # @api private
      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
