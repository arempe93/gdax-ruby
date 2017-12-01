# frozen_string_literal: true

module GDAX
  class Account < Resource
    include Operations::List
  end
end
