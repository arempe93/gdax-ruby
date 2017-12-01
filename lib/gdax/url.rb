# frozen_string_literal: true

module GDAX
  class URL
    attr_reader :base, :params

    def initialize(base, extra_params = {})
      @base, @params = extract_url_parts(base)
      add_params!(extra_params)
    end

    def initialize_dup(other)
      super
      @base = other.base.dup
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

    def query?
      !@params.empty?
    end

    def query_separator
      query? ? '&' : '?'
    end

    def to_s
      query? ? "#{@base}?#{to_query(@params)}" : @base
    end

    private

    def to_query(hash)
      hash.map { |k, v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
    end

    def extract_url_parts(url)
      base, query = url.split('?')

      return [base, {}] unless query

      params = query.split('&').each_with_object({}) do |pair, acc|
        key, value = pair.split('=').map { |str| CGI.unescape(str) }
        acc[key.to_sym] = value
      end

      [base, params]
    end
  end
end
