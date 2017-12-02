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
        base.extend(ClassMethods)
      end

      #
      # Reload data from the api
      #
      def reload(params = {})
        tap do
          response = Client.current.get(resource_url, params)
          initialize_from(response.data)
        end
      end
    end
  end
end
