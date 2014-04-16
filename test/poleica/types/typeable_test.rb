# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Typeable Module
class TypeableTest < Minitest::Test
  EXTENSION_NAMES ||= %w(doc pdf mp3 png)

  def test_that_it_extracts_a_mimetype
    expected_mime_types = %w(
      application/pdf
      audio/mpeg
      image/png
    )
    mime_types = files_enumerator.map(&:file_mimetype)
    # Don't test doc files, it doesnt behave the same way
    # on Linux or MacOS (maybe FIXME)
    mime_types.shift
    assert_equal(expected_mime_types, mime_types)
  end

  def test_that_it_extracts_an_extension
    expected_extensions = extension_names
    extensions          = files_enumerator.map(&:file_extension)
    assert_equal(expected_extensions, extensions)
  end

  def test_that_it_extracts_a_type_object
    expected_classes = [
      Poleica::Types::Document,
      Poleica::Types::General,
      Poleica::Types::Document,
      Poleica::Types::Image
    ]
    classes = files_enumerator.map do |type_detector|
      type_detector.file_type.class
    end
    assert(expected_classes, classes)
  end

  def test_that_it_returns_null_type_by_default
    mp3_path = "#{Support.support_path}/files/example.mp3"
    type_class = Poleica::Polei.new(mp3_path).file_type.class
    assert_equal(type_class, Poleica::Types::General)
  end

  ## Helpers

  def files_enumerator
    extension_names.map do |extension|
      file_path = "#{Support.support_path}/files/example.#{extension}"
      Poleica::Polei.new(file_path)
    end.to_enum
  end

  def extension_names
    EXTENSION_NAMES
  end
end # class TypeableTest
