# frozen_string_literal: true

module GDAX
  ##
  # GDAX Position
  #
  class Position < Resource
    include Operations::Get

    class << self
      ##
      # Close position
      #
      # @param [Boolean] repay_only Repay only flag
      #
      # @return [GDAX::Response] Response from api
      # @api public
      #
      def close(repay_only:)
        new.close(repay_only: repay_only)
      end
    end

    ##
    # Close position
    #
    # @param [Boolean] repay_only Repay only flag
    #
    # @return [GDAX::Response] Response from api
    # @api public
    #
    def close(repay_only:)
      Client.current.post('/position/close', repay_only: repay_only)
    end

    private

    # @api private
    def resource_url
      '/position'
    end
  end
end
