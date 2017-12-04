# frozen_string_literal: true

module GDAX
  class Product < Resource
    include Operations::List

    def buy(params)
      params[:side] = 'buy'
      params[:product_id] = id

      Order.create(params)
    end

    def history
      Client.current.get("#{resource_url}/candles")
    end

    def sell(params)
      params[:side] = 'sell'
      params[:product_id] = id

      Order.create(params)
    end

    def stats
      Client.current.get("#{resource_url}/stats")
    end

    def ticker
      Client.current.get("#{resource_url}/ticker")
    end

    def trades
      Client.current.get("#{resource_url}/trades")
    end

    def order_book(params)
      Client.current.get("#{resource_url}/book", params)
    end

    private

    def resource_url
      "/products/#{CGI.escape(id)}"
    end
  end
end
