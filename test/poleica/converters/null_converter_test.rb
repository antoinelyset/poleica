# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Null Converter Module
class NullConverterTest < Minitest::Test
  def test_it_returns_nil_on_to_method
    method_name = :to_random
    file        = Minitest::Mock.new
    converter   = Poleica::Converters::NullConverter.new(file)
    assert_nil(converter.send(method_name))
  end

  def test_it_raise_no_method_error_on_other_calls
    method_name = :random
    file        = Minitest::Mock.new
    converter   = Poleica::Converters::NullConverter.new(file)
    assert_raises(NoMethodError) { converter.send(method_name) }
  end
end # class NullConverterTest