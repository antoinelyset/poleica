# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Poleica Module
class PoleicaTest < Minitest::Test
  def test_duck_type_path
    obj = Struct.new(:path).new("/test_path")
    polei = Poleica.new(obj)
    assert_equal('/test_path', polei.path)
  end
end # class PoleicaTest