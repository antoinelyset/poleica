# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    class GraphicsMagick
      COMPATIBLE_MIMETYPES = %w{
        image/x-portable-bitmap
        application/postscript
        image/x-portable-pixma
        image/x-ms-bmp
        image/svg+xml
        image/jpeg
        image/tiff
        image/gif
        image/png
      }

      COMPATIBLE_EXTENSIONS = %w{
        tiff
        jpeg
        ppm
        pgm
        pnm
        pbm
        bmp
        svg
        jpg
        tif
        gif
        png
      }

      attr_reader :file

      def initialize(file)
        @file = file
      end

      def to_png
        `gm convert #{file.path} #{file.name}.png`
      end
    end # class PDF
  end # module Converters
end # module Poleica