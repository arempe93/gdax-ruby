# frozen_string_literal: true

require 'logger'

require 'gdax/version'

#
# A Ruby client to GDAX REST API
#
module GDAX
  @api_base = 'https://api.gdax.com'

  @api_key = ENV['CB_ACCESS_KEY']
  @api_signature = ENV['CB_ACCESS_SIGN']
  @api_passphrase = ENV['CB_ACCESS_PASSPHRASE']

  @logger = Logger.new(STDOUT)

  class << self
    attr_accessor :api_base, :api_key, :api_signature, :api_passphrase, :logger
  end
end
