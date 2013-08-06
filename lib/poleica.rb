# -*- encoding: utf-8 -*-
module Poleica
  def self.new(file_or_path)
    file_or_path = file_or_path.path if file_or_path.respond_to?(:path)
    Polei.new(file_or_path)
  end
end # module Poleica

require 'poleica/version'

require 'poleica/types/pdf'
require 'poleica/types/image'
require 'poleica/types/document'
require 'poleica/types/typeable'
require 'poleica/types/general'
require 'poleica/types/all'

require 'poleica/converters/utils'
require 'poleica/converters/general'
require 'poleica/converters/coercive'
require 'poleica/converters/graphics_magick'
require 'poleica/converters/libre_office'
require 'poleica/converters/convertible'

require 'poleica/pathable'

require 'poleica/polei'
