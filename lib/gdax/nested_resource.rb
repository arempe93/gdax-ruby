# frozen_string_literal: true

module GDAX
  class NestedResource < Resource
    attr_reader :parent_id

    def initialize(params = {})
      super(params)
      @parent_id = @params.delete(:parent_id)
    end
  end
end
