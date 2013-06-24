# -*- encoding: utf-8 -*-
source 'https://rubygems.org'

# Specify your gem's dependencies in poleica.gemspec
gemspec

group :test do
  gem 'minitest'
  gem 'coveralls', require: false
end

group :development do
  gem 'pry-plus', require: 'pry'

  gem 'rubocop', :github => 'bbatsov/rubocop'

  # Guards
  gem 'guard-rubocop'
  gem 'guard-minitest', :github => 'guard/guard-minitest'
end