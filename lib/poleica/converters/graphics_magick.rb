# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    # The GraphicsMagick converter, use the 'gm' command to convert images and
    # documents
    class GraphicsMagick
      include Poleica::Converters::Utils

      BIN_PATHS = {
        linux:  '/usr/bin/gm',
        osx:    '/usr/local/bin/gm'
      }

     COMPATIBLE_TYPES = [
       Types::Image,
       Types::PDF
     ]

      attr_reader :polei

      def initialize(polei)
        @polei = polei
      end

      def to_png(options = {})
        opts_gen = OptionsGenerator.new(options)
        output_file_path = polei.path_with_md5(:png)
        cmd = "#{bin_path} convert "
        cmd << "#{polei.path}#{opts_gen.generate} "
        cmd << "#{output_file_path}"
        `#{cmd}`
        File.exists?(output_file_path) ? output_file_path : nil
      end

      private

      # Generate options for the gm command
      # @options page [Array, Integer]
      class OptionsGenerator
        attr_reader :options

        def initialize(options = {})
          defaults = { page: 0 }
          @options = defaults.merge(options)
        end

        def generate
          options = "#{pages_options} "
          options << "-resize #{resize_options} " if resize_options
          options
        end

        private

        def pages_options
          @pages_options ||= Array(options[:page]).
            flatten.compact.uniq.sort.to_s
        end

        def resize_options
          return nil unless @resize_options ||
            options[:height] || options[:width]
          @resize_options = "#{options[:width]}x#{options[:height]}"
        end
      end # class OptionsGenerator
    end # class GraphicsMagick
  end # module Converters
end # module Poleica
