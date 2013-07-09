# -*- encoding: utf-8 -*-
require 'fileutils'

module Poleica
  module Converters
    # The LibreOffice converter, use the 'soffice' command to convert documents
    class LibreOffice
      include Poleica::Converters::Utils

      BIN_PATHS = {
        linux:  '/usr/bin/soffice',
        osx: '/Applications/LibreOffice.app/Contents/MacOS/soffice'
      }

      COMPATIBLE_MIMETYPES = [
        'application/vnd.oasis.opendocument.text', # .odt
        'application/vnd.ms-office',               # .doc
        'application/vnd.ms-excel',                # .xls
        'application/vnd.ms-office',               # .ppt, .pps
        'application/msword',                      # .doc
        'application/pdf',                         # .pdf
        'text/html',                               # .html, .htm
        'text/plain',                              # .txt
        'text/rtf'                                 # .rft
      ]

      COMPATIBLE_EXTENSIONS = %w{
        html
        htm
        odt
        doc
        xls
        ppt
        pps
        doc
        pdf
        txt
        rft
      }

      attr_reader :polei

      def initialize(polei)
        @polei = polei
      end

      def to_pdf(options = {})
        opts_gen         = OptionsGenerator.new(options, :pdf)
        output_dir_path  = File.dirname(polei.path)
        output_file_path = path_with_md5_for_extension(:pdf)
        cmd  = "#{bin_path} #{opts_gen.generate} "
        cmd << "--outdir #{output_dir_path} "
        cmd << "#{temp_file.path}"
        `#{cmd}`
        File.exists?(output_file_path) ? output_file_path : nil
      ensure
        FileUtils.rm(temp_file.path, force: true)
      end

      def bin_path
        path = BIN_PATHS[host_os] || BIN_PATHS[:linux]
        raise "LibreOffice not found @ #{path}" unless File.exists?(path)
        path
      end

      private

      # Create a temp file, libreoffice doesn't accept a full output path,
      # just a directory
      # @return tempfile [File]
      def temp_file
        @temp_path ||= path_with_md5_for_extension(polei.file_extension)
        return File.new(@temp_path) if File.exists?(@temp_path)
        FileUtils.cp(polei.path, @temp_path)
        File.new(@temp_path)
      end

      # Generate options for the soffice command
      class OptionsGenerator
        attr_reader :options, :format

        def initialize(options = {}, format = :pdf)
          defaults = {}
          @options = defaults.merge(options)
          @format  = format
        end

        def generate
          "#{default_options} #{format}"
        end

        private

        def default_options
          '--headless --invisible --norestore --nolockcheck --convert-to'
        end

        def pages_options
          @pages_options ||= Array(options[:page]).
            flatten.compact.uniq.sort.to_s
        end
      end # class OptionsGenerator
    end # class LibreOffice
  end # module Converters
end # module Poleica
