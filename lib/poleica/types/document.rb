# -*- encoding: utf-8 -*-
module Poleica
  module Types
    # Document Type
    class Document
      COMPATIBLE_MIMETYPES = [
        'application/vnd.oasis.opendocument.text', # .odt
        'application/vnd.ms-office',               # .doc
        'application/vnd.ms-excel',                # .xls
        'application/vnd.ms-office',               # .ppt, .pps
        'application/msword',                      # .doc
        'text/html',                               # .html, .htm
        'text/plain',                              # .txt
        'text/rtf'                                 # .rft
      ]

      # Unsupported :( : key, pages
      COMPATIBLE_EXTENSIONS = %w{
        html
        htm
        odt
        doc
        docx
        xls
        xlsx
        ppt
        pptx
        pps
        txt
        rft
      }

      def initialize(file_path)

      end
    end # class Document
  end # module Types
end # module Poleica
