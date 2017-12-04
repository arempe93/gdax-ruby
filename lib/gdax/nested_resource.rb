# frozen_string_literal: true

module GDAX
  ##
  # Nested Resource
  #
  class NestedResource < Resource
    # ID of parent model
    attr_reader :parent_id

    ##
    # Initialize with parent id
    #
    # @param [Hash] params Request parameters
    #
    # @option params [String] parent_id ID of parent model
    #
    # @api private
    #
    def initialize(params = {})
      super(params)
      @parent_id = @params.delete(:parent_id)
    end
  end
end
