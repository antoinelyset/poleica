# -*- encoding: utf-8 -*-
source 'https://rubygems.org'

# Specify your gem's dependencies in poleica.gemspec
gemspec

group :test do
  gem 'rake'
  gem 'minitest'
  gem 'rubocop',   github:  'bbatsov/rubocop'
  gem 'coveralls', require: false
end

group :development do
  gem 'jazz_hands'

  # Guards
  gem 'guard-rubocop'
  gem 'guard-minitest', github: 'guard/guard-minitest'
end
