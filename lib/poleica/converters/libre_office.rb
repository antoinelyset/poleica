# -*- encoding: utf-8 -*-
require 'fileutils'

module Poleica
  module Converters
    # The LibreOffice converter, use the 'soffice' command to convert documents
    class LibreOffice
      include Poleica::Converters::Utils

      COMPATIBLE_TYPES = [
        Types::Document
      ]

      attr_reader :polei

      def initialize(polei)
        @polei = polei
      end

      def to_pdf(options = {})
        opts_gen = OptionsGenerator.new(polei, options, :pdf)
        exec_with_timeout(bin_path, opts_gen.generate)
        expected_file_path = opts_gen.output_path
        File.exist?(expected_file_path) ? expected_file_path : nil
      ensure
        temp_file_path = opts_gen.temp_path
        File.delete(temp_file_path) if File.exist?(temp_file_path)
      end

      # Generate options for the soffice command
      class OptionsGenerator
        attr_reader :options, :format, :polei, :output_path

        def initialize(polei, options = {}, format = :pdf)
          @polei       = polei
          @format      = format
          @output_path = options[:path] || polei.path_with_md5(format)
          @options     = default_options.merge(options)
        end

        def default_options
          { path: polei.path_with_md5 }
        end

        def generate
          [
            default_arguments,
            format,
            output_options
          ].flatten
        end

        # Generate a temp path, and create the file this is needed in order to
        # have the right filename, LibreOffice just copy the original filename
        # in the choosen directory, it doesn't accept filename params.
        # @return temp_path [String]
        def temp_path
          @temp_path ||= generate_temp_path
          FileUtils.cp(polei.path, @temp_path) unless File.exist?(@temp_path)
          @temp_path
        end

        private

        def generate_temp_path
          if File.directory?(options[:path])
            File.join(options[:path], File.basename(polei.path_with_md5))
          else
            pathable_object.path_for_extension(File.extname(polei.path))
          end
        end

        def pathable_object
          pathable_object = Struct.new(:path).new(options[:path])
          pathable_object.extend(Poleica::Pathable)
        end

        def default_arguments
          %w(
            --nologo
            --headless
            --invisible
            --norestore
            --nolockcheck
            --convert-to
          )
        end

        def output_options
          dir_path = File.dirname(temp_path)
          ['--outdir', dir_path, temp_path]
        end
      end # class OptionsGenerator
    end # class LibreOffice
  end # module Converters
end # module Poleica
