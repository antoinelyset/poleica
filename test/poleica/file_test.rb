# -*- encoding: utf-8 -*-
require 'test_helper'

class PoleiTest < Minitest::Test
  def test_it_returns_name
    file = Poleica::Polei.new("#{Support.support_path}/example.mp3")
    assert_equal('example', file.name)
  end
end # class PoleiTest