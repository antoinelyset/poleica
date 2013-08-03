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

     DEFAULT_MEASURE = 612

      attr_reader :polei

      def initialize(polei)
        @polei = polei
      end

      def to_png(options = {})
        opts_gen = OptionsGenerator.new(polei, options)
        cmd = "#{bin_path} convert "
        cmd << "#{Utils.escape(polei.path)}#{opts_gen.generate}"
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
          @options = default_options.merge(options)
        end

        def generate
          "#{page_options} #{orient_options}"   +
            " #{thumbnail_or_resize_options}"   +
            " #{Utils.escape(output_options)}"
        end

        def [](key)
          options[key]
        end

        private

        def default_options
          {
            height: DEFAULT_MEASURE,
            width: DEFAULT_MEASURE,
            force_resize: false,
            auto_orient: true,
            thumbnail: false,
            page: 0,
          }
        end

        def page_options
          @page_options ||=
            "#{Array(options[:page]).flatten.compact.uniq.sort.to_s}"
        end

        def orient_options
          @orient_options ||= options[:auto_orient] ? '-auto-orient' : ''
        end

        def thumbnail_or_resize_options
          @thumbnail_or_resize_options ||=
            options[:thumbnail] ? thumbnail_options : resize_options
        end

        def thumbnail_options
          @thumbnail_options ||=
            "-thumbnail #{options[:width]}x"  +
                       "#{options[:height]}^" +
                       ' -gravity center'     +
              " -extent #{options[:width]}x"  +
                       "#{options[:height]}"
        end

        def resize_options
          @resize_options ||=
            "-resize #{options[:width]}x" +
                    "#{options[:height]}" +
                    "#{'!' if options[:force_resize]}"
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
