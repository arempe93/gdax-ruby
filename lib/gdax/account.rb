# frozen_string_literal: true

module GDAX
  ##
  # GDAX Account
  #
  class Account < Resource
    include Operations::Get
    include Operations::List

    ##
    # Get history for this account
    #
    # @return [GDAX::NestedCollection] Collection of GDAX::AccountHistory
    # @api public
    #
    def history
      NestedCollection.new(AccountHistory, parent_id: id).reload
    end

    ##
    # Get holds for this account
    #
    # @return [GDAX::NestedCollection] Collection of GDAX::AccountHold
    # @api public
    #
    def holds
      NestedCollection.new(AccountHold, parent_id: id).reload
    end
  end
end
