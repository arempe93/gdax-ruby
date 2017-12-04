# frozen_string_literal: true

module GDAX
  ##
  # GDAX Product
  #
  class Product < Resource
    include Operations::List

    ##
    # Place a buy order for this product
    #
    # @return [GDAX::Order] Order placed
    # @api public
    #
    def buy(params)
      params[:side] = 'buy'
      params[:product_id] = id

      Order.create(params)
    end

    ##
    # Get product historical rates
    #
    # @param [Hash] params Request params
    #
    # @option params [DateTime,String] start ISO8601 timestamp
    # @option params [DateTime,String] end ISO8601 timestamp
    # @option params [Integer] granularity Timeslice in seconds
    #
    # @return [GDAX::Response] Response from api
    # @api public
    #
    def history(params)
      Client.current.get("#{resource_url}/candles", params)
    end

    ##
    # Place a sell order for this product
    #
    # @return [GDAX::Order] Order placed
    # @api public
    #
    def sell(params)
      params[:side] = 'sell'
      params[:product_id] = id

      Order.create(params)
    end

    ##
    # Get 24hr stats for this product
    #
    # @return [GDAX::Response] Response from api
    # @api public
    #
    def stats
      Client.current.get("#{resource_url}/stats")
    end

    ##
    # Snapshot of last trade for this product
    #
    # @return [GDAX::Response] Response from api
    # @api public
    #
    def ticker
      Client.current.get("#{resource_url}/ticker")
    end

    ##
    # Latest trades for this product
    #
    # @return [GDAX::Response] Response from api
    # @api public
    #
    def trades
      Client.current.get("#{resource_url}/trades")
    end

    ##
    # Get all open orders for this product
    #
    # @param [Hash] params Request parameters
    #
    # @option params [Integer] level Response detail: 1-3
    #
    # @return [GDAX::Response] Response from api
    # @api public
    #
    def order_book(params)
      Client.current.get("#{resource_url}/book", params)
    end

    private

    # @api private
    def resource_url
      "/products/#{CGI.escape(id)}"
    end
  end
end
