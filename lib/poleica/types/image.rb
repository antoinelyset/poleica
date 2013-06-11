# -*- encoding: utf-8 -*-
module Poleica
  module Types
    class Image
      COMPATIBLE_MIMETYPES = [
        'image/x-portable-pixmap', # .ppm, .pgm, .pbm, .pnm
        'image/x-portable-bitmap', # .pbm
        'image/x-ms-bmp',          # .bmp
        'image/svg+xml',           # .svg
        'image/jpeg',              # .jpeg, .jpg
        'image/tiff',              # .tiff, .tif
        'image/gif',               # .gif
        'image/png'                # .png
      ]

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

      def initialize(file_path)

      end
    end # class Image
  end # module Types
end # module Poleica