# -*- encoding: utf-8 -*-
module Poleica
  class TypeDetector
    attr_reader :file_path, :file_extension, :file_mimetype

    # Detect
    def initialize(file_path)
      @file_path = file_path
    end

    def file_extension
      @file_extension ||= extract_extension(file_path)
    end

    def file_mimetype
      @file_mimetype ||= extract_mimetype(file_path)
    end

    def file_type
      @file_type ||= detect_type_with_extension(file_extension) ||
                     detect_type_with_mimetype(file_mimetype)
    end

    private

    MIMETYPE_EXTRACT_REGEX = /([^;:]+)/

    TYPES = [Document, Image]

    def extract_mimetype(file_path)
      `file -b --mime '#{file_path}'`.strip[MIMETYPE_EXTRACT_REGEX] || ''
    end

    def extract_extension(file_path)
      File.extname(file_path)[1..-1] || ''
    end

    def detect_type_with_extension(extension)
      TYPES.find(nil) { |type| type::EXTENSIONS.include?(extension) }
    end

    def detect_type_with_mimetype(mimetype)
      TYPES.find(nil) { |type| type::MIMETYPES.include?(mimetype) }
    end
  end # class TypeDetector
end # module Poleica