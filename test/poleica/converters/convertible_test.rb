# -*- encoding: utf-8 -*-
require 'test_helper'

class ConvertibleTest < Minitest::Test

  def test_that_it_extracts_converters
    mp3_path = "#{Support.support_path}/files/example.mp3"
    file = Poleica::Polei.new(mp3_path)
    # FIXME
    assert_equal([], file.send(:compatible_converters))
  end

  def test_that_it_extracts_converters_2
    png_path = "#{Support.support_path}/files/example.png"
    file = Poleica::Polei.new(png_path)
    expected_converters = [Poleica::Converters::GraphicsMagick]
    # FIXME
    assert_equal(expected_converters, file.send(:compatible_converters))
  end

end # class ConvertibleTest