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

      COMPATIBLE_TYPES = [
        Types::Document
      ]

      attr_reader :polei

      def initialize(polei)
        @polei = polei
      end

      def to_pdf(options = {})
        opts_gen = OptionsGenerator.new(polei, options, :pdf)
        cmd      = "#{bin_path} #{opts_gen.generate}"
        exec_with_timeout(cmd)
        expected_file_path = opts_gen[:path] || polei.path_with_md5(:pdf)
        File.exists?(expected_file_path) ? expected_file_path : nil
      ensure
        temp_file_path = opts_gen.temp_path
        File.delete(temp_file_path) if File.exists?(temp_file_path)
      end

      private

      # Generate options for the soffice command
      class OptionsGenerator
        attr_reader :options, :format, :polei

        def initialize(polei, options = {}, format = :pdf)
          defaults = {}
          @options = defaults.merge(options)
          @polei   = polei
          @format  = format
        end

        def generate
          "#{default_options} #{format} #{output_options}"
        end

        def [](key)
          options[key]
        end

        # Generate a temp path, and create the file this is needed in order to
        # have the right filename, LibreOffice just copy the original filename
        # in the choosen directory, it doesn't accept filename params.
        # @return temp_path [String]
        def temp_path
          @temp_path ||= generate_temp_path
          FileUtils.cp(polei.path, @temp_path) unless File.exists?(@temp_path)
          @temp_path
        end

        private

        def generate_temp_path
          if options[:path]
            if File.directory?(options[:path])
              basename = File.basename(polei.path_with_md5)
              return File.join(options[:path], basename)
            end
            extension = File.extname(polei.path)
            return pathable_object.path_for_extension(extension[1..-1])
          else
            return polei.path_with_md5(polei.file_extension)
          end
        end

        def pathable_object
            pathable_object = Struct.new(:path).new(options[:path])
            pathable_object.extend(Poleica::Pathable)
        end

        def default_options
          '--headless --invisible --norestore --nolockcheck --convert-to'
        end

        def output_options
          dir_path = File.dirname(temp_path)
          "--outdir #{Utils.escape(dir_path)} #{Utils.escape(temp_path)}"
        end

        def pages_options
          @pages_options ||= Array(options[:page]).
            flatten.compact.uniq.sort.to_s
        end
      end # class OptionsGenerator
    end # class LibreOffice
  end # module Converters
end # module Poleica
