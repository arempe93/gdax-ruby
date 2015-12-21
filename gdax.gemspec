#!/usr/bin/env gem build
# frozen_string_literal: true

require 'base64'
require File.expand_path('../lib/gdax/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'gdax'
  s.version     = GDAX::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Andrew Rempe']
  s.email       = [Base64.decode64('YW5kcmV3cmVtcGVAZ21haWwuY29t\n')]
  s.summary     = 'Ruby client for the GDAX Exchange API'
  s.description = 'Full featured Ruby client to GDAX Exchange API by Coinbase'
  s.license     = 'MIT'

  s.required_ruby_version = Gem::Requirement.new '>= 2.0'

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rake', '~> 10.5.0'
  s.add_development_dependency 'rspec', '~> 3.4.0'
  s.add_development_dependency 'rubocop', '= 0.51.0'
  s.add_development_dependency 'term-ansicolor', '~> 1.3.0'
  s.add_development_dependency 'tins', '= 1.6.0'
  s.add_development_dependency 'yard'

  s.files         = `git ls-files`.split "\n"
  s.test_files    = `git ls-files -- spec/*`.split "\n"
  s.require_paths = %w[lib]
end
