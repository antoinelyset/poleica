# -*- encoding: utf-8 -*-
source 'https://rubygems.org'

# Specify your gem's dependencies in poleica.gemspec
gemspec

if RUBY_VERSION.split('.').first == '2'
  platform :mri do
    gem 'pry-byebug'
  end
end

group :test do
  gem 'rake'
  gem 'minitest'
  gem 'rubocop'
  gem "codeclimate-test-reporter", require: nil
end

group :development do
  # Guards
  gem 'guard-rubocop'
  gem 'guard-minitest', github: 'guard/guard-minitest'
end
