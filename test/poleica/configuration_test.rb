# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Configuration Converter Module
class ConfigurationTest < Minitest::Test
  def test_timeout_configuration
    start_time = Time.now
    Poleica.configure { |config| config.timeout = 1 }
    Poleica::Converters::Utils.exec_with_timeout('sleep 10') rescue nil
    duration = Time.now - start_time
    assert(duration < 10)
  ensure
    Poleica.configure { |config| config.timeout = 120 }
  end

  def test_graphics_magick_configuration
    Poleica.configure do |config|
      config.graphics_magick[:bin_paths] = { linux: '', osx: '' }
    end
    expected_message = 'Poleica::Converters::GraphicsMagick not found @ '
    assert_raises(RuntimeError, expected_message) do
      Poleica.new('test/support/files/example.pdf').to_png
    end
  ensure
    Poleica.reset_configuration
  end

  def test_libre_office_configuration
    Poleica.configure do |config|
      config.libre_office[:bin_paths] = { linux: '', osx: '' }
    end
    expected_message = 'Poleica::Converters::LibreOffice not found @ '
    assert_raises(RuntimeError, expected_message) do
      Poleica.new('test/support/files/example.doc').to_pdf
    end
  ensure
    Poleica.reset_configuration
  end
end # class ConfigurationTest
