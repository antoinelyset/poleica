# -*- encoding: utf-8 -*-
if ENV['COVERAGE']
  require 'coveralls'
  Coveralls.wear!
  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
end

gem     'minitest'
require 'minitest/autorun'
require 'poleica'

module Support
  def self.support_path
    @support_path ||= File.expand_path('../support', __FILE__)
  end
end