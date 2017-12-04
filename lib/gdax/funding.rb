# frozen_string_literal: true

module GDAX
  ##
  # GDAX Funding
  #
  class Funding < Resource
    include Operations::List

    class << self
      ##
      # Repay funding, oldest first
      #
      # @param [String] amount Amount of currency to repay
      # @param [String] currency Currency code
      #
      # @return [GDAX::Response] Response from api
      # @api public
      #
      def repay(amount:, currency:)
        Client.current.post('/funding/repay', amount: amount,
                                              currency: currency)
      end
    end
  end
end
