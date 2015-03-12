# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    class GraphicsMagick
      # Generate options for the GraphicsMagick to_png
      # @options page [Array, Integer]
      class ConvertOptionsGenerator
        attr_reader :polei, :options, :output_path

        def initialize(polei, options = {})
          @polei     = polei
          @options   = default_options.merge(options)
        end

        def generate
          [
            'convert',
            "#{polei.path}#{page_options}",
            orient_options,
            resize_options,
            output_options
          ].flatten
        end

        private

        def default_options
          {
            height: DEFAULT_MEASURE,
            width: DEFAULT_MEASURE,
            force_resize: false,
            auto_orient: true,
            page: 0
          }
        end

        def page_options
          @page_options ||=
            "#{Array(options[:page]).flatten.compact.uniq.sort}"
        end

        def orient_options
          @orient_options ||= options[:auto_orient] ? '-auto-orient' : ''
        end

        def resize_options
          @resize_options ||= [
            '-resize',
            "#{options[:width]}x#{options[:height]}" \
            "#{'!' if options[:force_resize]}"
          ]
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
      end # class OptionsGenerator
    end # class GraphicsMagick
  end # module Converters
end # module Poleica
