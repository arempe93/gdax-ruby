# frozen_string_literal: true

module GDAX
  class Withdrawal < Resource
    class << self
      ##
      # Make a withdrawal to a saved payment method
      #
      # @param [String] id Payment method id
      # @param [String] amount Amount to withdrawal
      # @param [String] currency Currency code
      #
      # @return [GDAX::Withdrawal] An Withdrawal object with data
      # @api public
      #
      def payment_method(id:, amount:, currency:)
        params = { payment_method_id: id, amount: amount, currency: currency }
        create(params, type: 'payment-method')
      end

      ##
      # Make a withdrawal to a coinbase account
      #
      # @param [String] id Coinbase account id
      # @param [String] amount Amount to withdrawal
      # @param [String] currency Currency code
      #
      # @return [GDAX::Withdrawal] An Withdrawal object with data
      # @api public
      #
      def coinbase(id:, amount:, currency:)
        params = { coinbase_account_id: id, amount: amount, currency: currency }
        create(params, type: 'coinbase-account')
      end

      ##
      # Make a withdrawal to a crypto address
      #
      # @param [String] address Cryptocurrency address
      # @param [String] amount Amount to withdrawal
      # @param [String] currency Currency code
      #
      # @return [GDAX::Withdrawal] An Withdrawal object with data
      # @api public
      #
      def crypto(address:, amount:, currency:)
        params = { crypto_address: address, amount: amount, currency: currency }
        create(params, type: 'crypto')
      end

      private

      # @api private
      def create(params, type:)
        response = Client.current.post("/withdrawals/#{type}", params)
        new(response.data)
      end
    end
  end
end
