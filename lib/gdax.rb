# frozen_string_literal: true

require 'base64'
require 'cgi'
require 'faraday'
require 'logger'
require 'json'
require 'openssl'

require 'gdax/errors'

require 'gdax/client'
require 'gdax/response'
require 'gdax/url'

require 'gdax/version'

#
# A Ruby client to GDAX REST API
#
module GDAX
  # Default configuration
  @config = {
    api_base: 'https://api.gdax.com',
    api_key: ENV['GDAX_API_KEY'],
    api_secret: ENV['GDAX_API_SECRET'],
    api_passphrase: ENV['GDAX_API_PASSPHRASE'],
    logger: Logger.new(STDOUT)
  }

  class << self
    # Stores global configuration options
    attr_accessor :config

    #
    # Allows access to configuration options through dot-syntax
    #
    def method_missing(method_name, *args, &block)
      setter = method_name.to_s.end_with?('=')
      key = method_name.to_s.chomp('=').to_sym

      if config.key?(key)
        setter ? config[key] = args.shift : config[key]
      else
        super
      end
    end

    #
    # Properly implements respond_to? for configuration options
    #
    def respond_to_missing?(method_name, include_private = false)
      @config.key?(method_name.to_sym) || super
    end
  end
end
