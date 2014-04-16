# -*- encoding: utf-8 -*-
module Poleica
  module Types
    # PDF Type
    class PDF
      COMPATIBLE_MIMETYPES = [
        'application/pdf' # pdf
      ]

      COMPATIBLE_EXTENSIONS = %w(
        pdf
      )

      def initialize(file_path)
      end
    end # class PDF
  end # module Types
end # module Poleica
