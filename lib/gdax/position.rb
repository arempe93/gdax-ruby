# frozen_string_literal: true

module GDAX
  class Position < Resource
    include Operations::Get

    class << self
      def close(repay_only:)
        new.close(repay_only: repay_only)
      end
    end

    def close(repay_only:)
      Client.current.post('/position/close', repay_only: repay_only)
    end

    def resource_url
      '/position'
    end
  end
end
