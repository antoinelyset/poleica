# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    # Null Object Pattern, this is the converter returned if no compatible
    # converters are found
    class Null
      attr_reader :polei
      def initialize(polei)
        @polei = polei
      end

      def method_missing(method, *args, &block)
        super unless method =~ /^to_/
      end
    end # class Null
  end # module Converters
end # module Poleica
