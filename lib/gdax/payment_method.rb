# frozen_string_literal: true

module GDAX
  ##
  # GDAX Payment Method
  #
  class PaymentMethod < Resource
    include Operations::List
  end
end
