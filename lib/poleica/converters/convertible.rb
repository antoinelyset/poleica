# -*- encoding: utf-8 -*-
module Poleica
  # Conversion Logic, given a type it can search for compatible converters
  module Convertible

    CONVERTERS = [
      Converters::GraphicsMagick,
      Converters::LibreOffice
    ]

    def method_missing(method, *args, &block)
      extension, options = Converters::Utils
        .extract_extension_and_options(method, args)
      return convert_to_extension(extension, options) if extension
      super
    end

    def convert_to_extension(extension, options = {})
      converter = converter_to_extension(extension).new(self)
      converter.send("to_#{extension}".to_sym, options)
    end

    def converter_to_extension(extension, filter = :mimetype)
      compatible_converter = compatible_converters.find do |converter|
        converter.method_defined?(:"to_#{extension}")
      end
      compatible_converter ||= Converters::Coercive
    end

    def compatible_converters
      @compatible_converters ||=
        compatible_converters_by_type(self.file_type.class) <<
         Converters::General
    end

    def compatible_convert_methods
      @compatible_convert_methods ||=
        compatible_converters.map do |c|
          convert_methods_for_converter(c)
        end.flatten
    end

    module_function

    def compatible_converters_by_type(type)
      CONVERTERS.select do |converter|
        converter::COMPATIBLE_TYPES.include?(type)
      end
    end

    def convert_methods_for_converter(converter)
      methods_for_converter(converter).reject { |m| !(m =~ /^to_(.*)/) }
    end

    def methods_for_converter(converter)
      converter.instance_methods(false).map(&:to_s)
    end

  end # module Convertible
end # module Poleica
