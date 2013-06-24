# -*- encoding: utf-8 -*-
require 'test_helper'
# Test the GraphicsMagick Converter Module
class GraphicsMagickTest < Minitest::Test
  def test_to_png
    pdf_polei = Poleica::Polei.new("#{Support.support_path}/files/example.pdf")
    data   = File.read(pdf_polei.path)
    md5    = Digest::MD5.new
    digest = md5.hexdigest(data)
    expected_path = "#{Support.support_path}/files/example-#{digest}.png"
    assert_equal(expected_path, pdf_polei.to_png)
  end
end # class GraphicsMagickTest