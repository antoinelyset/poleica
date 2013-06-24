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
end # class GeneralTest