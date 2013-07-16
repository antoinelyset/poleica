# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Convertible Module
class ConvertibleTest < Minitest::Test
  def test_that_it_extracts_converters
    mp3_path  = "#{Support.support_path}/files/example.mp3"
    mp3_polei = Poleica::Polei.new(mp3_path)
    # FIXME
    expected_converters = [Poleica::Converters::General]
    assert_equal(expected_converters, mp3_polei.send(:compatible_converters))
  end

  def test_that_it_extracts_converters_2
    png_path  = "#{Support.support_path}/files/example.png"
    png_polei = Poleica::Polei.new(png_path)
    expected_converters = [
      Poleica::Converters::GraphicsMagick,
      Poleica::Converters::General
    ]
    # FIXME
    assert_equal(expected_converters, png_polei.send(:compatible_converters))
  end

  def test_convert_to_extension
    png_path  = "#{Support.support_path}/files/example.png"
    png_polei = Poleica::Polei.new(png_path)
    converter = png_polei.send(:converter_to_extension, :png)
    assert_equal(Poleica::Converters::GraphicsMagick, converter)
  end

  def test_default_coercive_converter
    png_path  = "#{Support.support_path}/files/example.png"
    png_polei = Poleica::Polei.new(png_path)
    converter = png_polei.send(:converter_to_extension, :mp3)
    assert_equal(Poleica::Converters::Coercive, converter)
  end

  def test_method_missing_raises_exception
    method_name = :random
    png_path    = "#{Support.support_path}/files/example.png"
    png_polei   = Poleica::Polei.new(png_path)
    assert_raises(NoMethodError) { png_polei.send(method_name) }
  end
end # class ConvertibleTest
