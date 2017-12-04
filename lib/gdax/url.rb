# frozen_string_literal: true

module GDAX
  class URL
    attr_accessor :path

    attr_reader :params

    def initialize(path, params = {})
      @path = path
      @params = params
    end

    def initialize_dup(other)
      super
      @path = other.path.dup
      @params = other.params.dup
    end

    def [](key)
      @params[key]
    end

    def []=(key, value)
      @params[key] = value
    end

    def add_params(**params)
      dup.tap { |d| d.add_params!(params) }
    end

    def add_params!(**params)
      tap { @params.merge!(params) }
    end

    def clear_params
      dup.tap { |d| d.clear_params! }
    end

    def clear_params!
      tap { @params = {} }
    end

    def drop_params(*keys)
      dup.tap { |d| d.drop_params!(*keys) }
    end

    def drop_params!(*keys)
      tap { Array(keys).each { |key| @params.delete(key) } }
    end

    def location
      "#{GDAX.api_base}#{@path}"
    end

    def path_with_query
      query? ? "#{@path}?#{query}" : @path
    end

    def query
      @params.keys.sort.map do |key|
        value = @params[key]
        "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end.join('&')
    end

    def query?
      !@params.empty?
    end

    def query_separator
      query? ? '&' : '?'
    end

    def to_s
      query? ? "#{location}?#{query}" : location
    end
  end
end
