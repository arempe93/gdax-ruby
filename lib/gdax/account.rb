# frozen_string_literal: true

module GDAX
  class Account < Resource
    include Operations::Get
    include Operations::List
  end
end
