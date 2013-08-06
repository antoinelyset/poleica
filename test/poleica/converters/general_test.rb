# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the General Converter Module
class GeneralTest < Minitest::Test
  def test_to_bin
    gif_path = "#{Support.support_path}/files/1px.gif"
    gif_data = File.binread(gif_path)
    gif_polei = Poleica::Polei.new(gif_path)
    assert_equal(gif_data, gif_polei.to_bin)
  end

  def test_it_returns_nil_on_to_method
    method_name = :to_random
    file        = Minitest::Mock.new
    converter   = Poleica::Converters::General.new(file)
    assert_nil(converter.send(method_name))
  end

  def test_it_raise_no_method_error_on_other_calls
    method_name = :random
    file        = Minitest::Mock.new
    converter   = Poleica::Converters::General.new(file)
    assert_raises(NoMethodError) { converter.send(method_name) }
  end
end # class GeneralTest
