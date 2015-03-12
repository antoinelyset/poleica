# -*- encoding: utf-8 -*-
if ENV['COVERAGE'] || ENV['TRAVIS']
  require 'coveralls'
  require 'simplecov'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  Coveralls.wear!
end

Bundler.require(:default, :test)

require 'minitest/autorun'
require 'poleica'

# The Support Module contains support methods for the tests
module Support
  module_function
  def support_path
    @support_path ||= File.expand_path('../support', __FILE__)
  end

  def path_without_extension(path)
    File.join(File.dirname(path), File.basename(path, '.*'))
  end

  def expected_converted_path(
    original_file_path  = "#{Support.support_path}/files/example.pdf",
    converted_extension = :png
  )
    data   = File.read(original_file_path)
    md5    = Digest::MD5.new
    digest = md5.hexdigest(data)
    path_without_extension(original_file_path) +
      "-#{digest}.#{converted_extension}"
  end
end # module Support
