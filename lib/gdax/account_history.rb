# frozen_string_literal: true

module GDAX
  ##
  # GDAX Account History
  #
  class AccountHistory < NestedResource
    class << self
      ##
      # Redefine resource url
      #
      # @api private
      #
      def resource_url(parent_id)
        "/accounts/#{CGI.escape(parent_id)}/ledger"
      end
    end
  end
end
