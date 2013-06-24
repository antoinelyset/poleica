# -*- encoding: utf-8 -*-
module Poleica
  # Retrieve the mimetype, the extension and the type of a file, it needs a
  # "path" method
  module Typeable
    def file_extension
      @file_extension ||= extract_extension
    end

    def file_mimetype
      @file_mimetype ||= extract_mimetype
    end

    def file_type
      @file_type ||= (detect_type_with_extension ||
                      detect_type_with_mimetype  ||
                      Types::Null).new(path)
    end

    private

    MIMETYPE_EXTRACT_REGEX = /([^;:]+)/

    TYPES = [
      Types::Image,
      Types::Document
    ]

    def extract_mimetype
      `file -b --mime '#{path}'`.strip[MIMETYPE_EXTRACT_REGEX] || ''
    end

    def extract_extension
      (::File.extname(path)[1..-1] || '').strip
    end

    def detect_type_with_extension
      TYPES.find do |type|
        type::COMPATIBLE_EXTENSIONS.include?(file_extension)
      end
    end

    def detect_type_with_mimetype
      TYPES.find do |type|
        type::COMPATIBLE_MIMETYPES.include?(file_mimetype)
      end
    end
  end # class Typeable
end # module Poleica