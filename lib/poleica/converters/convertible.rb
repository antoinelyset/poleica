# -*- encoding: utf-8 -*-
module Poleica
  module Convertible

    private

    CONVERTERS = [
      Converters::GraphicsMagick
    ]

    def convert_to_format(format)
      converter_for_format(format).new(self).send("to_#{format}".to_sym)
    end

    def converter_to_format(format, filter = :mimetype)
      converters = self.send("compatible_converters_by_#{filter}".to_sym)
      compatible_converter = converters.find do |converter|
        converter_methods  = converter.instance_methods(false).map(&:to_s)
        converter_methods.include?("to_#{format}")
      end
      compatible_converter ||= NullConverter
    end

    def compatible_converters
      compatible_converters_by_mimetype | compatible_converters_by_extension
    end

    def compatible_converters_by_mimetype
      CONVERTERS.select do |converter|
        converter::COMPATIBLE_MIMETYPES.include?(file_mimetype)
      end
    end

    def compatible_converters_by_extension
      CONVERTERS.select do |converter|
        converter::COMPATIBLE_EXTENSIONS.include?(file_extension)
      end
    end
  end # module Convertible
end # module Poleica