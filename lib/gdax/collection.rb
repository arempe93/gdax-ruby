# frozen_string_literal: true

module GDAX
  ##
  # Container for collections of Resources
  #
  class Collection
    include Enumerable

    # After pagination cursor from api headers
    attr_reader :after_cursor

    # Before pagination cursor from api headers
    attr_reader :before_cursor

    # Class of Resource this collection holds
    attr_reader :klazz

    # Items in the collection
    attr_reader :items

    # Params used in request
    attr_reader :params

    ##
    # Initialize a collection with a class and request parameters
    #
    # @param [Class] klazz Resource subclass
    # @param [Hash] params Request params
    #
    # @api private
    #
    def initialize(klazz, params)
      @klazz = klazz
      @params = params
      @items = []
    end

    ##
    # For Enumerable
    #
    def each(&block)
      @items.each(&block)
    end

    ##
    # Returns a new Collection, with the next page of results
    #
    # @return [GDAX::Collection] Collection with next page
    # @api public
    #
    def next
      dup.tap(&:next!)
    end

    ##
    # Replaces the current collection with the next page of results
    #
    # @return [GDAX::Collection] self
    # @api public
    #
    def next!
      clear_pagination
      @params[:after] = @after_cursor
      reload
    end

    ##
    # Returns a new Collection, with the previous page of results
    #
    # @return [GDAX::Collection] Collection with previous page
    # @api public
    #
    def previous
      dup.tap(&:previous!)
    end

    ##
    # Replaces the current collection with the previous page of results
    #
    # @return [GDAX::Collection] self
    # @api public
    #
    def previous!
      clear_pagination
      @params[:before] = before_cursor
      reload
    end

    ##
    # Reload collection from server
    #
    # @return [GDAX::Collection] self
    # @api public
    #
    def reload
      response = request_data

      @after_cursor = response.headers['CB-AFTER']
      @before_cursor = response.headers['CB-BEFORE']

      tap { load(response.data) }
    end

    ##
    # Size of elements in collection
    #
    # @api public
    #
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

    # @api private
    def request_data
      Client.current.get(@klazz.resource_url(@params), @params)
    end
  end
end
