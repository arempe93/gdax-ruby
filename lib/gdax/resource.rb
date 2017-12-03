# frozen_string_literal: true

module GDAX
  #
  # Abstract wrapper for objects corresponding to api endpoints
  #
  class Resource
    class << self
      #
      # Get relative path of this resource class
      #
      def resource_url(*)
        raise NotImplementedError 'Resource is an abstract class' if self == Resource
        "/#{CGI.escape(class_name.downcase)}s"
      end

      #
      # Get class name without module namespace
      #
      def class_name
        name.split('::').last
      end
    end

    # Response data
    attr_reader :data

    # Request params
    attr_reader :params

    #
    # Load resource with request params
    #
    def initialize(params = {})
      @params = params
      @data = {}
    end

    def load(data)
      tap { @data = data }
    end

    #
    # Key access to data
    #
    def [](key)
      @data[key]
    end

    #
    # Allow access to data through dot-syntax
    #
    def method_missing(method_name, *args, &block)
      @data.key?(method_name) ? @data[method_name] : super
    end

    #
    # Properly implements respond_to? for data
    #
    def respond_to_missing?(method_name, include_private = false)
      @data.key?(method_name) || super
    end

    def inspect
      "#<#{self.class} #{self}>"
    end

    def to_s
      @data.inspect
    end
  end
end
