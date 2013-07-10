# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Poleica Module
class PoleicaTest < Minitest::Test
  def test_duck_type_path
    obj   = Struct.new(:path).new("#{Support.support_path}/files/example.mp3")
    polei = Poleica.new(obj)
    assert_equal("#{Support.support_path}/files/example.mp3", polei.path)
  end
end # class PoleicaTest
