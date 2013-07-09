# -*- encoding: utf-8 -*-
module Poleica
  # Given a file and a method e.g : example.jpeg, to_png it searches for
  # compatible converters and calls it.
  module Convertible

    private

    CONVERTERS = [
      Converters::GraphicsMagick,
      Converters::LibreOffice
    ]

    def method_missing(method, *args, &block)
      extension = method.to_s.split(/^to_(.*)/)[1]
      return convert_to_extension(extension) if extension
      super
    end

    def convert_to_extension(extension, options = {})
      converter = converter_to_extension(extension).new(self)
      converter.send("to_#{extension}".to_sym, options)
    end

    def converter_to_extension(extension, filter = :mimetype)
      compatible_converter = compatible_converters.find do |converter|
        converter_methods  = converter.instance_methods(false).map(&:to_s)
        converter_methods.include?("to_#{extension}")
      end
      compatible_converter ||= Converters::NullConverter
    end

    def compatible_converters
      (compatible_converters_by_mimetype |
        compatible_converters_by_extension) << Converters::General
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
