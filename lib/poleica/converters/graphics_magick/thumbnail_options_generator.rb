# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    class GraphicsMagick
      # Generate options for the GraphicsMagick to_thumbnail
      # @options page [Array, Integer]
      class ThumbnailOptionsGenerator
        include Poleica::Converters::Utils
        attr_reader :polei, :options, :current_width,
                    :current_height, :output_path

        def initialize(polei, options = {})
          @polei     = polei
          @options   = default_options.merge(options)
          @current_width, @current_height = identify
        end

        def generate
          [
            'convert',
            "#{polei.path}[0]",
            orient_options,
            resize_options,
            output_options
          ].flatten
        end

        private

        def default_options
          {
            height: DEFAULT_MEASURE,
            width:  DEFAULT_MEASURE,
            auto_orient: true
          }
        end

        def orient_options
          @orient_options ||= options[:auto_orient] ? '-auto-orient' : ''
        end

        def resize_options
          @resize_options ||=
            [
              '-resize',
              "#{width_and_height_options}"
          ]
        end

        def width_and_height_options
          if current_width >= current_height
            width_only_option
          else
            height_only_option
          end
        end

        def width_only_option
          if percent(current_width, options[:width]) > 50
            "#{options[:width]}!x"
          else
            "#{current_width}x#{current_height}"
          end
        end

        def height_only_option
          if percent(current_height, options[:height]) > 50
            "x#{options[:height]}!"
          else
            "#{current_width}x#{current_height}"
          end
        end

        def identify
          line = exec_with_timeout(bin_path(GraphicsMagick), identify_options)
          width, height = line.split.first.split('x')
          [width.to_i, height.to_i]
        end

        def identify_options
          [
            'identify',
            '-format',
            '%wx%h ',
            polei.path
          ]
        end

        def percent(comparing, compared)
          (comparing.to_f / compared.to_f) * 100
        end

        def output_options
          @output_path = if options[:path]
                           if File.directory?(options[:path])
                             name = File.basename(polei.path_with_md5(:png))
                             File.join(options[:path], name)
                           else
                             options[:path]
                           end
                         else
                           polei.path_with_md5(:png)
                         end
        end
      end # class ThumbnailOptionsGenerator
    end # class GraphicsMagick
  end # module Converters
end # module Poleica
