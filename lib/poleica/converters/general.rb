# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    class General

      attr_reader :polei

      def initialize(polei)
        @polei = polei
      end

      def to_bin(options = {})
        File.binread(polei.path)
      end
    end # class General
  end # module Converters
end # module Poleica