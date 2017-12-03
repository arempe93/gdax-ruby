# frozen_string_literal: true

module GDAX
  class Funding < Resource
    include Operations::List

    def repay(amount:, currency:)
      Client.current.post('/funding/repay', amount: amount,
                                            currency: currency)
    end
  end
end
