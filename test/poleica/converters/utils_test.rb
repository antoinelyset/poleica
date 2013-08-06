# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Utils Converter Module
class UtilsTest < Minitest::Test
  def test_exec_with_timeout
    start_time = Time.now
    Poleica::Converters::Utils.exec_with_timeout('sleep 2', 0.1) rescue nil
    duration = Time.now - start_time
    assert(duration < 2)
  end

  def test_exec_with_timeout_exception
    assert_raises(Timeout::Error) do
      Poleica::Converters::Utils.exec_with_timeout('sleep 2', 0.1)
    end
  end
end
