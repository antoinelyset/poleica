# -*- encoding: utf-8 -*-
module Poleica
  # Configuration class
  class Configuration
    attr_accessor :timeout, :libre_office, :graphics_magick

    def initialize
      self.timeout         = 120
      self.libre_office    = init_libre_office_config
      self.graphics_magick = init_graphics_magick_config
    end

    def init_graphics_magick_config
      {
        bin_paths:
        {
          linux:  '/usr/local/bin/gm',
          osx:    '/usr/local/bin/gm'
        }
      }
    end

    def init_libre_office_config
      {
        bin_paths:
        {
          linux:  '/usr/lib/libreoffice/program/soffice.bin',
          osx: '/Applications/LibreOffice.app/Contents/MacOS/soffice.bin'
        }
      }
    end
  end # class Configuration

  def self.configure
    yield(configuration) if block_given?
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset_configuration
    @configuration = Configuration.new
  end
end # module Poleica
