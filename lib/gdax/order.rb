# frozen_string_literal: true

module GDAX
  ##
  # GDAX Order
  #
  class Order < Resource
    include Operations::Create
    include Operations::Delete
    include Operations::Get
    include Operations::List

    class << self
      ##
      # Place a buy order
      #
      # @param [Hash] params Request parameters
      #
      # @return [GDAX::Order] Order placed
      # @api public
      #
      def buy(params)
        params[:side] = 'buy'
        create(params)
      end

      ##
      # Cancel all open orders
      #
      # @param [Hash] params Request parameters
      #
      # @option params [String] product_id Limit to a specific product
      #
      # @return [GDAX::Response] Response from api
      # @api public
      #
      def cancel_all(params)
        Client.current.delete('/orders', params)
      end

      ##
      # Place a sell order
      #
      # @param [Hash] params Request parameters
      #
      # @return [GDAX::Order] Order placed
      # @api public
      #
      def sell(params)
        params[:side] = 'sell'
        create(params)
      end
    end

    alias cancel delete
  end
end
