# frozen_string_literal: true

module GDAX
  class Order < Resource
    include Operations::Create
    include Operations::Delete
    include Operations::Get
    include Operations::List

    class << self
      def cancel_all(params)
        Client.current.delete('/orders', params)
      end
    end

    alias cancel delete
  end
end
