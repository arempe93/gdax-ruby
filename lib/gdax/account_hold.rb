# frozen_string_literal: true

module GDAX
  ##
  # GDAX Account Hold
  #
  class AccountHold < NestedResource
    class << self
      ##
      # Redefine resource url
      #
      # @api private
      #
      def resource_url(parent_id)
        "/accounts/#{CGI.escape(parent_id)}/holds"
      end
    end
  end
end
