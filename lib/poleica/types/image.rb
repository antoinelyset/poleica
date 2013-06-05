# -*- encoding: utf-8 -*-
module Poleica
  module Types
    class Image
      MIMETYPES = [
        'image/x-portable-pixmap', # .ppm, .pgm, .pbm, .pnm
        'image/x-portable-bitmap', # .pbm
        'image/x-ms-bmp',          # .bmp
        'image/svg+xml',           # .svg
        'image/jpeg',              # .jpeg, .jpg
        'image/tiff',              # .tiff, .tif
        'image/gif',               # .gif
        'image/png'                # .png
      ]

      EXTENSIONS = [
        'tiff',
        'jpeg',
        'ppm',
        'pgm',
        'pbm',
        'pnm',
        'pbm',
        'bmp',
        'svg',
        'jpg',
        'tif',
        'gif',
        'png'
      ]
    end # class Image
  end # module Types
end # module Poleica