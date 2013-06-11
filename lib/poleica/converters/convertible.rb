# -*- encoding: utf-8 -*-
module Poleica
  module Convertible

    private

    CONVERTERS = [
      Converters::GraphicsMagick
    ]

    def compatible_converters
      compatible_converters_by_mimetype | compatible_converters_by_extension
    end

    def compatible_converters_by_mimetype
      CONVERTERS.select do |converter|
        converter::COMPATIBLE_MIMETYPES.include?(file_mimetype)
      end
    end

    def compatible_converters_by_extension
      CONVERTERS.select do |converter|
        converter::COMPATIBLE_EXTENSIONS.include?(file_extension)
      end
    end
  end # module Convertible
end # module Poleica