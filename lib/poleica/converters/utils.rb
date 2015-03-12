# -*- encoding: utf-8 -*-
require 'digest/md5'
require 'childprocess'

module Poleica
  module Converters
    # An Utility module for the converters needs to be include
    module Utils
      HOST_OS ||= (defined?('RbConfig') ? RbConfig : Config)::CONFIG['host_os']

      def windows?
        !!HOST_OS.match(/mswin|windows|cygwin/i)
      end

      def osx?
        !!HOST_OS.match(/darwin/i)
      end

      def linux?
        !!HOST_OS.match(/linux/i)
      end

      def host_os
        [:windows, :osx, :linux].find { |os| send(:"#{os}?") }
      end

      def bin_path(given_class = nil)
        converter     = :"#{underscorize(given_class || self.class)}"
        configuration = Poleica.configuration.send(converter)
        bin_paths     = configuration[:bin_paths]
        path          = bin_paths[host_os] || bin_paths[:linux]
        fail "#{converter} not found @ #{path}" unless File.exist?(path)
        path
      end

      def underscorize(camel_cased_word)
        word = camel_cased_word.to_s
        word = word[((word.rindex('::') + 2) || 0)..-1]
        word.gsub!(/([A-Z]+)/, '_\1').gsub!(/^_/, '').downcase!
        word
      end

      module_function

      def extract_extension_and_options(method, args = [])
        extension  = method.to_s.split(/^to_(.*)/)[1]
        options    = args.last if args.last.is_a?(Hash)
        options    ||= {}
        [extension, options]
      end

      def exec_with_timeout(bin, args = [], options = {})
        timeout           = options[:timeout] || Poleica.configuration.timeout
        process           = ChildProcess.build(bin, *Array(args).map(&:to_s))
        map_std(process) do
          process.start
          timeout ? process.poll_for_exit(timeout) : process.wait
        end
      rescue ChildProcess::TimeoutError => e
        process.stop
        raise Poleica::TimeoutError, e.message
      end

      def map_std(process, &block)
        stdout, stdout_w, stderr, stderr_w = init_process_std(process)
        yield
        stderr_w.close.nil? && fail_if_error(process, stderr)
        stdout_w.close.nil? && stdout.read
      ensure
        stderr_w.close unless stderr_w.closed?
        stdout_w.close unless stdout_w.closed?
      end

      def init_process_std(process)
        stdout, stdout_w = IO.pipe
        stderr, stderr_w = IO.pipe

        process.io.stdout = stdout_w
        process.io.stderr = stderr_w

        [stdout, stdout_w, stderr, stderr_w]
      end

      def fail_if_error(process, stderr)
        unless process.exit_code == 0
          message = "Code: #{process.exit_code} #{stderr.read}"
          fail Poleica::ProcessError, message
        end
      end
    end # module Utils
  end # module Converters
end # module Poleica
