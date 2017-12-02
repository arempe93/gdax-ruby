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
      def resource_url
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

    #
    # Load resource with response data
    #
    def initialize(data = {})
      initialize_from(data)
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

    #
    # Get relative path of this resource instance
    #
    def resource_url
      "#{self.class.resource_url}/#{CGI.escape(id)}"
    end

    def inspect
      "#<#{self.class} #{self}>"
    end

    def to_s
      @data.inspect
    end

    private

    # @api private
    def initialize_from(data)
      @data = data
    end
  end
end
