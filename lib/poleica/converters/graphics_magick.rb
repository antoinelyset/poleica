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
        opts_gen = OptionsGenerator.new(polei, options)
        cmd = "#{bin_path} convert "
        cmd << "#{polei.path}#{opts_gen.generate} "
        `#{cmd}`
        expected_file_path = opts_gen[:path]
        File.exists?(expected_file_path) ? expected_file_path : nil
      end

      private

      # Generate options for the gm command
      # @options page [Array, Integer]
      class OptionsGenerator
        attr_reader :polei, :options

        def initialize(polei, options = {})
          @polei   = polei
          defaults = { page: 0 }
          @options = defaults.merge(options)
        end

        def generate
          "#{pages_options} #{resize_options} #{output_options}"
        end

        def [](key)
          options[key]
        end

        private

        def pages_options
          @pages_options ||= Array(options[:page]).
            flatten.compact.uniq.sort.to_s
        end

        def resize_options
          return nil unless @resize_options ||
            options[:height] || options[:width]
          @resize_options = "-resize #{options[:width]}x#{options[:height]}"
        end

        def output_options
          options[:path] = if options[:path]
                             if File.directory?(options[:path])
                               basename = File.basename(polei.path_with_md5)
                               File.join(options[:path], basename)
                             else
                               options[:path]
                             end
                           else
                             polei.path_with_md5(:png)
                           end
        end
      end # class OptionsGenerator
    end # class GraphicsMagick
  end # module Converters
end # module Poleica
