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

  GDAX.api_base = 'https://api-public.sandbox.gdax.com'
  GDAX.api_key = ENV['GDAX_SANDBOX_API_KEY']
  GDAX.api_secret = ENV['GDAX_SANDBOX_API_SECRET']
  GDAX.api_passphrase = ENV['GDAX_SANDBOX_API_PASSPHRASE']

  IRB.start
end
