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
      dup.tap { d.clear_params! }
    end

    def clear_params!
      tap { @params = {} }
    end

    def drop_param(key)
      dup.tap { drop_param!(key) }
    end

    def drop_param!(key)
      tap { params.delete(key) }
    end

    def location
      "#{GDAX.api_base}#{@path}"
    end

    def query?
      !@params.empty?
    end

    def query_separator
      query? ? '&' : '?'
    end

    def to_s
      query? ? "#{location}?#{to_query(@params)}" : location
    end

    private

    def to_query(hash)
      hash.map { |k, v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
    end
  end
end
