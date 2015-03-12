# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    # The General converter, it handles any file type and return null for
    # unknown conversion
    class General
      COMPATIBLE_TYPES = [
        Types::All
      ]

      attr_reader :polei

      def initialize(polei)
        @polei = polei
      end

      def to_bin(_options = {})
        File.binread(polei.path)
      end

      def method_missing(method, *args, &block)
        super unless method =~ /^to_/
      end
    end # class General
  end # module Converters
end # module Poleica
