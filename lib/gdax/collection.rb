# frozen_string_literal: true

module GDAX
  class Collection
    include Enumerable

    attr_reader :after_cursor

    attr_reader :before_cursor

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

    def next
      dup.tap { |d| d.next! }
    end

    def next!
      clear_pagination
      @params[:after] = @after_cursor
      reload
    end

    def previous
      dup.tap { |d| d.previous! }
    end

    def previous!
      clear_pagination
      @params[:before] = before_cursor
      reload
    end

    def reload
      response = Client.current.get(@klazz.resource_url(@params), @params)

      @after_cursor = response.headers['CB-AFTER']
      @before_cursor = response.headers['CB-BEFORE']

      tap { load(response.data) }
    end

    def size
      @items.size
    end

    def inspect
      "#<GDAX::Collection(#{klazz.class_name}) #{self}>"
    end

    def to_s
      @items.inspect
    end

    private

    # @api private
    def clear_pagination
      @params.delete(:before)
      @params.delete(:after)
    end

    # @api private
    def load(items)
      @items = items.map do |data|
        params = { id: data[:id] }
        klazz.new(params).load(data)
      end
    end
  end
end
