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

      def bin_path
        converter     = :"#{underscorize(self.class)}"
        configuration = Poleica.configuration.send(converter)
        bin_paths     = configuration[:bin_paths]
        path          = bin_paths[host_os] || bin_paths[:linux]
        fail "#{self.class} not found @ #{path}" unless File.exist?(path)
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

      def exec_with_timeout(bin, args = [], timeout = nil, no_stdout = true)
        args              = Array(args).map(&:to_s)
        timeout         ||= Poleica.configuration.timeout
        process           = ChildProcess.build(bin, *args)
        set_process_stdout(process, no_stdout)
        process.start
        timeout ? process.poll_for_exit(timeout) : process.wait
      rescue ChildProcess::TimeoutError => e
        process.stop
        raise Poleica::TimeoutError, e.message
      end

      def set_process_stdout(process, no_stdout)
        if no_stdout
          null              = IO.new(IO.sysopen('/dev/null', 'w'), 'w')
          process.io.stdout = process.io.stderr = null
        else
          process.io.inherit!
        end
      end
    end # module Utils
  end # module Converters
end # module Poleica
