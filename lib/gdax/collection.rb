# frozen_string_literal: true

module GDAX
  class Collection
    include Enumerable

    # Class of Resource this collection holds
    attr_reader :klazz

    # Items in the collection
    attr_reader :items

    # Params used in request
    attr_reader :params

    def initialize(klazz, params)
      @klazz = klazz
      @params = params
      @items = []
    end

    def each(&block)
      @items.each(&block)
    end

    def reload
      response = Client.current.get(@klazz.resource_url(@params), @params)
      tap { load(response.data) }
    end

    def inspect
      "#<GDAX::Collection(#{klazz.class_name}) #{self}>"
    end

    def to_s
      @items.inspect
    end

    private

    # @api private
    def load(items)
      @items = items.map do |data|
        params = { id: data[:id] }
        klazz.new(params).load(data)
      end
    end
  end
end
