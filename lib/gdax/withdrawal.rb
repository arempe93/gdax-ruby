# frozen_string_literal: true

module GDAX
  class Withdrawal < Resource
    class << self
      def payment_method(id:, amount:, currency:)
        params = { payment_method_id: id, amount: amount, currency: currency }
        create(params, type: 'payment-method')
      end

      def coinbase(**params)
        params = { coinbase_account_id: id, amount: amount, currency: currency }
        create(params, type: 'coinbase-account')
      end

      def crypto(address:, amount:, currency:)
        params = { crypto_address: address, amount: amount, currency: currency }
        create(params, type: 'crypto')
      end

      private

      def create(params, type:)
        response = Client.current.post("/withdrawals/#{type}", params)
        new(response.data)
      end
    end
  end
end
