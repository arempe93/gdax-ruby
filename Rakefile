# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.setup :default, :test, :development

Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec

require 'rubocop/rake_task'
RuboCop::RakeTask.new

task default: %i[rubocop spec]

require 'yard'
DOC_FILES = %w[lib/**/*.rb README.md].freeze

YARD::Rake::YardocTask.new(:doc) do |t|
  t.files = DOC_FILES
end

require 'irb'
desc 'Open irb with gem loaded'
task :console do
  require 'gdax'
  ARGV.clear

  GDAX.api_key = 'test_api_key'
  GDAX.api_secret = Base64.encode64('test_api_secret')
  GDAX.api_passphrase = 'test_api_passphrase'

  IRB.start
end
