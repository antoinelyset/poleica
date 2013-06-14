# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    class GraphicsMagick
      include Poleica::Converters::Utils

      COMPATIBLE_MIMETYPES = %w{
        image/x-portable-bitmap
        application/postscript
        image/x-portable-pixma
        application/pdf
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
        pdf
      }

      attr_reader :polei

      def initialize(polei)
        @polei = polei
      end

      def to_png(options = {})
        converted_file_path = path_with_md5_for_extention(:png)
        `gm convert #{polei.path} #{converted_file_path}`
        File.exists?(converted_file_path) ? converted_file_path : nil
      end
    end # class GraphicsMagick
  end # module Converters
end # module Poleica