# frozen_string_literal: true

module GDAX
  class NestedCollection < Collection
    attr_reader :parent_id

    def initialize(klazz, params)
      super(klazz, params)
      @parent_id = @params.delete(:parent_id)
    end

    def reload
      response = Client.current.get(@klazz.resource_url(@parent_id), @params)
      tap { load(response.data) }
    end
  end
end
