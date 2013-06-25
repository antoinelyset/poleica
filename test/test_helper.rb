# -*- encoding: utf-8 -*-
if ENV['COVERAGE'] || ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
end

gem     'minitest'
require 'minitest/autorun'
require 'poleica'
# The Support Module contains support methods for the tests
module Support
  module_function
  def support_path
    @support_path ||= File.expand_path('../support', __FILE__)
  end
end