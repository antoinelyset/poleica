# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the LibreOffice Converter Module
class LibreOfficeTest < Minitest::Test

  DOC_PATH = "#{Support.support_path}/files/example.doc"

  def setup
    clean_pdf_file
  end

  def test_to_pdf_returned_path
    returned_path = doc_polei.to_pdf
    expected_path = Support.expected_converted_path(DOC_PATH, :pdf)
    assert_equal(expected_path, returned_path)
    clean_pdf_file
  end

  def test_to_pdf_create_a_file
    returned_path = doc_polei.to_pdf
    assert(returned_path && File.exists?(returned_path))
    clean_pdf_file
  end

  private

  def clean_pdf_file
    if File.exists?(Support.expected_converted_path(DOC_PATH, :pdf))
      File.delete(Support.expected_converted_path(DOC_PATH, :pdf))
    end
  end

  def doc_polei
    Poleica::Polei.new("#{Support.support_path}/files/example.doc")
  end
end # class LibreOfficeTest
