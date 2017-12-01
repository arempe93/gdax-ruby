# frozen_string_literal: true

module GDAX
  module Operations
    module List
      module ClassMethods
        def list(params = {})
          Collection.new(self, params).reload
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
