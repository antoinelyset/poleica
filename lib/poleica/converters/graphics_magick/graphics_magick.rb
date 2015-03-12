# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    # The GraphicsMagick converter, use the 'gm' command to convert images and
    # documents
    class GraphicsMagick
      include Poleica::Converters::Utils

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
        opts_gen = ConvertOptionsGenerator.new(polei, options)
        exec_with_timeout(bin_path, opts_gen.generate)
        expected_file_path = opts_gen.output_path
        File.exist?(expected_file_path) ? expected_file_path : nil
      end

      def to_thumbnail(options = {})
        opts_gen = ThumbnailOptionsGenerator.new(polei, options)
        exec_with_timeout(bin_path, opts_gen.generate)
        expected_file_path = opts_gen.output_path
        File.exist?(expected_file_path) ? expected_file_path : nil
      end
    end # class GraphicsMagick
  end # module Converters
end # module Poleica
