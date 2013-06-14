# -*- encoding: utf-8 -*-
require 'test_helper'

class ConvertibleTest < Minitest::Test

  def test_that_it_extracts_converters
    mp3_path = "#{Support.support_path}/files/example.mp3"
    file = Poleica::File.new(mp3_path)
    assert_equal([], file.compatible_converters)
  end

  def test_that_it_extracts_converters_2
    png_path = "#{Support.support_path}/files/example.png"
    file = Poleica::File.new(png_path)
    expected_converters = [Poleica::Converters::GraphicsMagick]
    assert_equal(expected_converters, file.compatible_converters)
  end

end # class ConvertibleTest