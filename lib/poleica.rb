# -*- encoding: utf-8 -*-
# The Awesome Namespace
# Poleica is a general converter
module Poleica
  def self.new(file_or_path)
    file_or_path = file_or_path.path if file_or_path.respond_to?(:path)
    Polei.new(file_or_path)
  end
end # module Poleica

require 'poleica/version'
require 'poleica/configuration'
require 'poleica/errors'

require 'poleica/types/pdf'
require 'poleica/types/image'
require 'poleica/types/document'
require 'poleica/types/typeable'
require 'poleica/types/general'
require 'poleica/types/all'

require 'poleica/converters/utils'
require 'poleica/converters/general'
require 'poleica/converters/coercive'
require 'poleica/converters/libre_office'
require 'poleica/converters/graphics_magick/graphics_magick'
require 'poleica/converters/graphics_magick/thumbnail_options_generator'
require 'poleica/converters/graphics_magick/convert_options_generator'
# /!\ Should be last converters
require 'poleica/converters/convertible'

require 'poleica/pathable'

require 'poleica/polei'
