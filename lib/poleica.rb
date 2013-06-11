# -*- encoding: utf-8 -*-
module Poleica
  def self.new(file_or_io_path)
    # Detect type -> Coerce -> Convert
  end
end # module Poleica

require 'poleica/version'

require 'poleica/types/null'
require 'poleica/types/image'
require 'poleica/types/document'
require 'poleica/types/typeable'

require 'poleica/converters/graphics_magick'
require 'poleica/converters/convertible'

require 'poleica/file'