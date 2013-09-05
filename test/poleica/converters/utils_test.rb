# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Utils Converter Module
class UtilsTest < Minitest::Test
  def test_exec_with_timeout
    start_time = Time.now
    Poleica::Converters::Utils.exec_with_timeout('sleep', 2, 0.1) rescue nil
    duration = Time.now - start_time
    assert(duration < 2)
  end

  def test_exec_with_timeout_kill
    assert(`ps -a | grep soffice.bin | grep -v grep`.empty?)
    Poleica.configure { |conf| conf.timeout = 0.001 }
    Poleica.new("#{Support.support_path}/files/example.doc").to_png rescue nil
    assert(`ps -a | grep example.doc | grep -v grep`.empty?)
  ensure
    Poleica.configure { |config| config.timeout = 120 }
  end
end
