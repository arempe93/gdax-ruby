# frozen_string_literal: true

module GDAX
  ##
  # GDAX Coinbase Account
  #
  class CoinbaseAccount < Resource
    include Operations::List
  end
end
