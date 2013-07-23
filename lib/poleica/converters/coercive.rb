# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    # The Coercive converter, it tries to coerce the polei
    class Coercive

      # TODO Think about another way of declare return types
      TYPE_RETURNED_BY_METHOD = {
        to_pdf: Types::PDF,
        to_png: Types::Image
      }

      attr_reader :polei

      def initialize(polei)
        @polei = polei
      end

      private

      def method_missing(method, *args, &block)
        extension  = method.to_s.split(/^to_(.*)/)[1]
        options    = args.last if args.last.is_a?(Hash)
        options    ||= {}
        return try_convert(method, options) if extension
        super
      end

      def try_convert(method, options = {})
        coerced_path = coerce(method, options)
        return nil unless coerced_path
        converted_path = Poleica.new(coerced_path).send(method.to_sym, options)
        File.delete(coerced_path)
        converted_path
      end

      def coerce(method, options)
        conversion_hash = find_next_converter_by_method(method)
        return nil unless conversion_hash
        next_method     = conversion_hash.keys.first
        polei.send(next_method.to_sym, options)
      end

      # Find the next method and converter needed to execute
      # a given conversion
      # @param <Symbol/String> the given method conversion name
      # @return [Hash<Symbol, Converter>] the next method needed to execute
      def find_next_converter_by_method(origin_method)
        next_converters_by_method.find do |converter_by_method|
          conv = converter_by_method.values.first
          conv.method_defined?(origin_method.to_sym)
        end
      end

      # Returns a hash with the method to execute and the Converters
      # reachable by it
      # @return [Array[Hash<Symbol,Converters>]]
      def next_converters_by_method
        polei.compatible_convert_methods.map do |m|
          ret_type = TYPE_RETURNED_BY_METHOD[m.to_sym]
          next unless ret_type
          convs = Poleica::Convertible.
            compatible_converters_by_type(ret_type)
          convs.map { |conv| { m.to_sym => conv } }
        end.compact.flatten(1)
      end
    end # class Coercive
  end # module Converters
end # module Poleica
