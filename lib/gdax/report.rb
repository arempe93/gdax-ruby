# frozen_string_literal: true

module GDAX
  ##
  # GDAX Report
  #
  class Report < Resource
    include Operations::Create
    include Operations::Get
  end
end
