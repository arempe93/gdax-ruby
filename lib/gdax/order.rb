# frozen_string_literal: true

module GDAX
  class Order < Resource
    include Operations::Create
    include Operations::Delete
    include Operations::Get
    include Operations::List

    class << self
      def buy(params)
        params[:side] = 'buy'
        create(params)
      end

      def cancel_all(params)
        Client.current.delete('/orders', params)
      end

      def sell(params)
        params[:side] = 'sell'
        create(params)
      end
    end

    alias cancel delete
  end
end
