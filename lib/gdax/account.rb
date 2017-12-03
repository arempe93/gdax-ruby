# frozen_string_literal: true

module GDAX
  class Account < Resource
    include Operations::Get
    include Operations::List

    def history
      NestedCollection.new(AccountHistory, parent_id: id).reload
    end

    def holds
      NestedCollection.new(AccountHold, parent_id: id).reload
    end
  end
end
