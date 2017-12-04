# frozen_string_literal: true

module GDAX
  ##
  # Nested Collection
  #
  class NestedCollection < Collection
    # ID of parent model
    attr_reader :parent_id

    ##
    # Initialize a collection with parent id
    #
    # @param [Hash] params Request parameters
    #
    # @option params [String] parent_id ID of parent model
    #
    # @api private
    #
    def initialize(klazz, params)
      super(klazz, params)
      @parent_id = @params.delete(:parent_id)
    end

    private

    # @api private
    def request_data
      Client.current.get(@klazz.resource_url(@parent_id), @params)
    end
  end
end
