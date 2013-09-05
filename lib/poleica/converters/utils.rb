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
        [:windows, :osx, :linux].find { |os| self.send(:"#{os}?") }
      end

      def bin_path
        bin_path_key = :BIN_PATHS # rubocop:disable SymbolName
        bin_paths    = self.class.const_get(bin_path_key)
        path         = bin_paths[host_os] || bin_paths[:linux]
        raise "#{self.class} not found @ #{path}" unless File.exists?(path)
        path
      end

      module_function

      def extract_extension_and_options(method, args = [])
        extension  = method.to_s.split(/^to_(.*)/)[1]
        options    = args.last if args.last.is_a?(Hash)
        options    ||= {}
        [extension, options]
      end

      def exec_with_timeout(bin, args = [], timeout = nil, is_stdout = true)
        args      = Array(args).map(&:to_s)
        timeout ||= Poleica.configuration.timeout
        null      = IO.new(IO.sysopen('/dev/null','w'), 'w')
        process   = ChildProcess.build(bin, *args).start
        process.io.stdout = process.io.stderr = null
        process.poll_for_exit(timeout)
      rescue ChildProcess::TimeoutError => e
        process.stop && raise(e)
      ensure
        null && null.close
      end
    end # module Utils
  end # module Converters
end # module Poleica
