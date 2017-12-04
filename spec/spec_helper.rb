require 'rspec'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'bundler'
Bundler.setup :default, :test
Bundler.require

require 'coveralls'
Coveralls.wear!

require 'gdax'

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    @api_stubs = Faraday::Adapter::Test::Stubs.new
    @connection = Faraday.new do |c|
      c.adapter :test, @api_stubs
    end

    Thread.current[:gdax_client] = GDAX::Client.new(@connection)
  end
end
