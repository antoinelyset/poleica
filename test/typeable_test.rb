# -*- encoding: utf-8 -*-
require File.expand_path('../test_helper', __FILE__)

class TypeableTest < Minitest::Test
  EXTENSION_NAMES ||= %w{doc pdf mp3 png}

  def test_that_it_extracts_a_mimetype
    expected_mime_types = %w{
                            application/vnd.ms-office
                            application/pdf
                            audio/mpeg
                            image/png
                          }
    mime_types = type_detectors_enumerator.map(&:file_mimetype)
    assert_equal(expected_mime_types, mime_types)
  end

  def test_that_it_extracts_an_extension
    expected_extensions = extension_names
    extensions          = type_detectors_enumerator.map(&:file_extension)
    assert_equal(expected_extensions, extensions)
  end

  def test_that_it_extracts_a_type_object
    expected_classes = [
                         Poleica::Types::Document,
                         Poleica::Types::Null,
                         Poleica::Types::Document,
                         Poleica::Types::Image
                       ]
    classes = type_detectors_enumerator.map do |type_detector|
      type_detector.file_type.class
    end
    assert(expected_classes, classes)
  end

  def test_that_it_returns_null_type_by_default
    mp3_path = "#{support_path}/files/example.mp3"
    type_class = Poleica::File.new(mp3_path).file_type.class
    assert_equal(type_class, Poleica::Types::Null)
  end

  ## Helpers

  def type_detectors_enumerator
    extension_names.map do |extension|
      file_path = "#{support_path}/files/example.#{extension}"
      Poleica::File.new(file_path)
    end.to_enum
  end

  def support_path
    @support_path ||= File.expand_path('../support', __FILE__)
  end

  def extension_names
    EXTENSION_NAMES
  end
end