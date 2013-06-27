# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    # The GraphicsMagick converter, use the 'gm' command to convert images and
    # documents
    class GraphicsMagick
      include Poleica::Converters::Utils

      BIN_PATHS = {
        linux:  '/usr/bin/gm',
        osx: '/usr/local/Cellar/graphicsmagick/1.3.18/bin/gm'
      }

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

      def to_png(options = {})
        opts_gen = OptionsGenerator.new(options)
        converted_file_path = path_with_md5_for_extention(:png)
        cmd = "#{bin_path} convert "
        cmd << "#{polei.path}#{opts_gen.generate} "
        cmd << "#{converted_file_path}"
        `#{cmd}`
        File.exists?(converted_file_path) ? converted_file_path : nil
      end

      def bin_path
        path = BIN_PATHS[host_os] || BIN_PATHS[:linux]
        raise "GraphicsMagick not found @ #{path}" unless File.exists?(path)
        path
      end

      private

      # Generate options for the gm command
      class OptionsGenerator
        attr_reader :options

        def initialize(options = {})
          defaults = { page: 0 }
          @options = defaults.merge(options)
        end

        def generate
          "#{pages_options}"
        end

        private

        def pages_options
          @pages_options ||= Array(options[:page]).
            flatten.compact.uniq.sort.to_s
        end
      end
    end # class GraphicsMagick
  end # module Converters
end # module Poleica
