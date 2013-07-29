# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the GraphicsMagick Converter Module
class GraphicsMagickTest < Minitest::Test

  PDF_PATH = "#{Support.support_path}/files/example.pdf"

  def setup
    clean_png_file
  end

  def test_to_png_returned_path
    returned_path = pdf_polei.to_png
    expected_path = Support.expected_converted_path(PDF_PATH, :png)
    assert_equal(expected_path, returned_path)
    clean_png_file
  end

  def test_to_png_create_a_file
    returned_path = pdf_polei.to_png
    assert(returned_path && File.exists?(returned_path))
    clean_png_file
  end

  def test_to_png_path_option
    path_option   = "#{Support.support_path}/files/path_test.png"
    returned_path = pdf_polei.to_png(path: path_option)
    assert(returned_path)
    assert(File.exists?(path_option))
    assert(File.exists?(returned_path))
    assert_equal(returned_path, path_option)
    File.delete(path_option) if File.exists?(path_option)
  end

  def test_to_png_path_with_spaces
    path_option   = "#{Support.support_path}/files/path with spaces.png"
    returned_path = pdf_polei.to_png(path: path_option)
    assert(returned_path)
    assert(File.exists?(path_option))
    assert(File.exists?(returned_path))
    assert_equal(returned_path, path_option)
    File.delete(path_option) if File.exists?(path_option)
  end

  def test_path_folder
    path_option = '/tmp/'
    expected_path = "/tmp/#{File.basename(pdf_polei.path_with_md5)}"
    returned_path = pdf_polei.to_png(path: path_option)
    assert(returned_path)
    assert(File.exists?(expected_path))
    assert(File.exists?(returned_path))
    assert_equal(expected_path, returned_path)
    File.delete(expected_path) if File.exists?(expected_path)
  end

  def test_force_resize_option
    returned_path = pdf_polei.to_png(width: 100,
                                     height: 100,
                                     force_resize: true)
    expected_path = Support.expected_converted_path(PDF_PATH, :png)
    bin_path = Poleica::Converters::GraphicsMagick.new(pdf_polei).bin_path
    assert_equal(expected_path, returned_path)
    size = `#{bin_path} identify #{returned_path}`.split[2][/(\w)*/]
    assert_equal('100x100', size)
    clean_png_file
  end

  def test_resize_option
    returned_path = pdf_polei.to_png(width: 100,
                                     height: 100)
    expected_path = Support.expected_converted_path(PDF_PATH, :png)
    bin_path = Poleica::Converters::GraphicsMagick.new(pdf_polei).bin_path
    assert_equal(expected_path, returned_path)
    size = `#{bin_path} identify #{returned_path}`.split[2][/(\w)*/]
    assert_equal('77x100', size)
    clean_png_file
  end

  private

  def clean_png_file
    if File.exists?(Support.expected_converted_path(PDF_PATH, :png))
      File.delete(Support.expected_converted_path(PDF_PATH, :png))
    end
  end

  def pdf_polei
    Poleica::Polei.new("#{Support.support_path}/files/example.pdf")
  end
end # class GraphicsMagickTest
