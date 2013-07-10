# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the Polei Class
class PoleiTest < Minitest::Test
  def test_it_returns_name
    polei = Poleica::Polei.new("#{Support.support_path}/files/example.mp3")
    assert_equal('example', polei.name)
  end

  def test_it_returns_path
    file_path = "#{Support.support_path}/files/example.mp3"
    polei     = Poleica::Polei.new(file_path)
    assert_equal(file_path, polei.path)
  end
end # class PoleiTest
