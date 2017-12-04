# frozen_string_literal: true

module GDAX
  ##
  # GDAX Currency
  #
  class Currency < Resource
    include Operations::List

    class << self
      def endpoint
        'currencies'
      end
    end
  end
end
