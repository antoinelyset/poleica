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