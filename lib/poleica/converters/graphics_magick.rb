# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    # The GraphicsMagick converter, use the 'gm' command to convert images and
    # documents
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

      COMPATIBLE_CONVERTING_EXTENSIONS = %w{
        png
        pdf
        jpeg
      }

      attr_reader :polei

      def initialize(polei)
        @polei = polei
      end

      # Meta-programmatically defines a to_#{extension} (e.g: to_png) for each
      # COMPATIBLE_CONVERTING_EXTENSIONS
      COMPATIBLE_CONVERTING_EXTENSIONS.each do |extension|
        define_method("to_#{extension}".to_sym) do |options|
          converted_file_path = path_with_md5_for_extention(extension.to_sym)
          `gm convert #{polei.path} #{converted_file_path}`
          File.exists?(converted_file_path) ? converted_file_path : nil
        end
      end
    end # class GraphicsMagick
  end # module Converters
end # module Poleica