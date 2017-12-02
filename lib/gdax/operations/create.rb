# frozen_string_literal: true

module GDAX
  module Operations
    module Create
      module ClassMethods
        def create(params)
          response = Client.current.post(resource_url, params)
          new(response.data)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
