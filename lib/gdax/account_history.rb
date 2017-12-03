# frozen_string_literal: true

module GDAX
  class AccountHistory < NestedResource
    class << self
      def resource_url(parent_id)
        "/accounts/#{CGI.escape(parent_id)}/ledger"
      end
    end
  end
end
