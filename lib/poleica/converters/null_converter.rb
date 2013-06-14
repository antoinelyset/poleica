# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    class NullConverter
      def initialize(file)
        @file = file
      end

      def method_missing(method, *args, &block)
        super unless method =~ /to_/
      end
    end # class NullConverter
  end # module Converters
end # module Poleica