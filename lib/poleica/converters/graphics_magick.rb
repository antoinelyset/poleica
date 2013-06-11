# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    class GraphicsMagick
      COMPATIBLE_MIMETYPES = [
        'image/gif',
        'image/png',
        'image/jpeg',
        'image/tiff',
        'image/svg+xml',
        'image/x-ms-bmp',
        'image/x-portable-bitmap',
        'application/postscript',
        'image/x-portable-pixma'
      ]

      COMPATIBLE_EXTENSIONS = [
        'tiff',
        'jpeg',
        'ppm',
        'pgm',
        'pnm',
        'pbm',
        'bmp',
        'svg',
        'jpg',
        'tif',
        'gif',
        'png'
      ]

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