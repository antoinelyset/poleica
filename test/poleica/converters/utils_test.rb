# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Utils Converter Module
class UtilsTest < Minitest::Test
  def test_exec_with_timeout
    start_time = Time.now
    Poleica::Converters::Utils.exec_with_timeout('sleep 2', 1) rescue nil
    duration = Time.now - start_time
    assert(duration < 2)
  end
end
