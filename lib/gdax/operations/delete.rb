# frozen_string_literal: true

module GDAX
  module Operations
    module Delete
      module ClassMethods
        def delete(id)
          new(id: id).delete
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      #
      # Delete this resource from the api
      #
      def delete(params = {})
        Client.current.delete(resource_url, params)
      end
    end
  end
end
