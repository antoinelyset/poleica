# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Configuration Converter Module
class ConfigurationTest < Minitest::Test
  def test_timeout_configuration
    start_time = Time.now
    Poleica.configure { |config| config.timeout = 1 }
    Poleica::Converters::Utils.exec_with_timeout('sleep 2') rescue nil
    duration = Time.now - start_time
    assert(duration < 2)
  ensure
    Poleica.configure { |config| config.timeout = 120 }
  end
end
