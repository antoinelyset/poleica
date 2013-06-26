# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Polei Class
class PoleiTest < Minitest::Test
  def test_it_returns_name
    polei = Poleica::Polei.new("#{Support.support_path}/example.mp3")
    assert_equal('example', polei.name)
  end
end # class PoleiTest