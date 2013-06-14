# -*- encoding: utf-8 -*-
require 'test_helper'

class UtilsTest < Minitest::Test
  def test_path_for_extension
    mp3_path = "#{Support.support_path}/files/example.mp3"
    mp3_polei = Poleica::Polei.new(mp3_path)
    expected_path = "#{Support.support_path}/files/example.png"
    converter = Poleica::Converters::GraphicsMagick.new(mp3_polei)
    assert_equal(expected_path, converter.send(:path_for_extension, :png))
  end
end