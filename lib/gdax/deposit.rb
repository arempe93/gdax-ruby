# frozen_string_literal: true

module GDAX
  ##
  # GDAX Deposit
  #
  class Deposit < Resource
    class << self
      ##
      # Make a depsit from a saved payment method
      #
      # @param [String] id Payment method id
      # @param [String] amount Amount to deposit
      # @param [String] currency Currency code
      #
      # @return [GDAX::Deposit] An Deposit object with data
      # @api public
      #
      def payment_method(id:, amount:, currency:)
        params = { payment_method_id: id, amount: amount, currency: currency }
        create(params, type: 'payment-method')
      end

      ##
      # Make a depsit from a coinbase account
      #
      # @param [String] id Coinbase account id
      # @param [String] amount Amount to deposit
      # @param [String] currency Currency code
      #
      # @return [GDAX::Deposit] An Deposit object with data
      # @api public
      #
      def coinbase(id:, amount:, currency:)
        params = { coinbase_account_id: id, amount: amount, currency: currency }
        create(params, type: 'coinbase-account')
      end

      private

      # @api private
      def create(params, type:)
        response = Client.current.post("/deposits/#{type}", params)
        new(response.data)
      end
    end
  end
end
