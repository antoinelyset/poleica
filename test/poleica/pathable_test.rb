# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Pathable Module
class PathableTest < Minitest::Test
  def test_path_for_extension
    mp3_path = "#{Support.support_path}/files/example.mp3"
    mp3_polei = Poleica::Polei.new(mp3_path)
    expected_path = "#{Support.support_path}/files/example.png"
    assert_equal(expected_path, mp3_polei.send(:path_for_extension, :png))
  end
end # class PathableTest
