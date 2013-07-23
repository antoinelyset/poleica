# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Coercive Converter Module

class CoerciveTest < Minitest::Test
  DOC_PATH = "#{Support.support_path}/files/example.doc"

  def test_find_next_converter_by_method
    conv_hash = coercive_conv.send(:find_next_converter_by_method, :to_png)
    assert_equal({ to_pdf: Poleica::Converters::GraphicsMagick }, conv_hash)
  end

  def test_next_converters_by_method
    next_convs     = coercive_conv.send(:next_converters_by_method)
    expected_convs = [{ to_pdf: Poleica::Converters::GraphicsMagick }]
    assert_equal(expected_convs, next_convs)
  end

  def test_try_convert_intermediary_file_creation
    coercive_conv.send(:coerce, :to_png, {})
    assert(File.exists?(expected_pdf_path))
    clean_png_file
    clean_pdf_file
  end

  def test_try_convert_file_creation
    coercive_conv.send(:try_convert, :to_png)
    assert(File.exists?(find_png_path))
    clean_png_file(find_png_path)
    clean_pdf_file
  end

  def test_coercive_conversion
    polei = Poleica.new(DOC_PATH)
    returned_path = polei.to_png
    assert(File.exists?(returned_path))
    clean_png_file(find_png_path)
  end

  def test_coercive_null_return
    polei = Poleica.new("#{Support.support_path}/files/example.mp3")
    returned_path = polei.to_png
    assert_equal(nil, returned_path)
  end

  private

  def clean_pdf_file
    File.exists?(expected_pdf_path) && File.delete(expected_pdf_path)
  end

  def clean_png_file(png_path = expected_png_path)
    File.exists?(png_path) && File.delete(png_path)
  end

  def expected_pdf_path
    Support.expected_converted_path(DOC_PATH, :pdf)
  end

  def expected_png_path
    Support.expected_converted_path(expected_pdf_path, :png)
  end

  # Find a the path of the converted png. It should be used when we
  # don't have the intermediate file since we need to calculate its
  # md5
  def find_png_path
    files = Dir["#{Support.support_path}/files/*"]
    start_path = Support.path_without_extension(expected_pdf_path)
    files.grep(/#{start_path}-\w+\.png$/).first
  end

  def coercive_conv
    doc_polei = Poleica::Polei.new("#{DOC_PATH}")
    Poleica::Converters::Coercive.new(doc_polei)
  end
end # class CoerciveTest
