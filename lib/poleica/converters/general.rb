# -*- encoding: utf-8 -*-
module Poleica
  module Converters
    # The General converter, it handles any file type.
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