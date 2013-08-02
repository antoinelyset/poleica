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

  def test_path_option
    path_option   = "#{Support.support_path}/files/path_test.pdf"
    returned_path = doc_polei.to_pdf(path: path_option)
    assert(returned_path)
    assert(File.exists?(path_option))
    assert(File.exists?(returned_path))
    assert_equal(returned_path, path_option)
    File.delete(path_option) if File.exists?(path_option)
  end

  def test_path_folder
    path_option = '/tmp/'
    returned_path = doc_polei.to_pdf(path: path_option)
    assert(returned_path)
    assert(File.exists?(path_option))
    assert(File.exists?(returned_path))
    assert_equal(returned_path, path_option)
  end

  def test_multithreading
    threads = multithreaded_conversion
    threads.each_with_index do |t, n|
      t.join
      assert_equal(t[:expected_path], t[:returned_path])
      assert(File.exists?(t[:expected_path]))
      File.delete(t[:expected_path]) if File.exists?(t[:expected_path])
    end
  end

  private

  def multithreaded_conversion(threads_number = 5)
    (0..threads_number - 1).map do |n|
      Thread.new do
        path_option = "#{Support.support_path}/files/path_test#{n}.pdf"
        Thread.current[:expected_path] = path_option
        Thread.current[:returned_path] = doc_polei.to_pdf(path: path_option)
      end
    end
  end

  def clean_pdf_file
    if File.exists?(Support.expected_converted_path(DOC_PATH, :pdf))
      File.delete(Support.expected_converted_path(DOC_PATH, :pdf))
    end
  end

  def doc_polei
    Poleica::Polei.new("#{Support.support_path}/files/example.doc")
  end
end # class LibreOfficeTest
