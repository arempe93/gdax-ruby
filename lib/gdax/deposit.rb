# frozen_string_literal: true

module GDAX
  class Deposit < Resource
    class << self
      def payment_method(id:, amount:, currency:)
        params = { id: id, amount: amount, currency: currency }
        create(params, type: 'payment-method')
      end

      def coinbase(id:, amount:, currency:)
        params = { id: id, amount: amount, currency: currency }
        create(params, type: 'coinbase-account')
      end

      private

      def create(params, type:)
        response = Client.current.post("/deposits/#{type}", params)
        new(response.data)
      end
    end
  end
end
