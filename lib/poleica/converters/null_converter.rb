# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    class NullConverter
      attr_reader :polei
      def initialize(polei)
        @polei = polei
      end

      def method_missing(method, *args, &block)
        super unless method =~ /^to_/
      end
    end # class NullConverter
  end # module Converters
end # module Poleica