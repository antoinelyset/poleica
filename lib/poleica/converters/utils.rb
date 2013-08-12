# -*- encoding: utf-8 -*-
require 'digest/md5'
require 'timeout'
require 'spoon'

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
        args = Array(args).map(&:to_s)
        timeout ||= Poleica.configuration.timeout
        pid = stdout_redirect(is_stdout) { Spoon.spawnp(bin, *args) }
        Timeout.timeout(timeout)   { Process.wait(pid) }
      rescue Timeout::Error => e
        Process.kill(:TERM, pid)
        raise e
      end

      def stdout_redirect(no_stdout = true)
        if no_stdout
          orig_stdout = $stdout.clone
          $stdout.reopen File.new('/dev/null', 'w')
          yield
        else
          yield
        end
      ensure
        $stdout.reopen orig_stdout if no_stdout
      end
    end # module Utils
  end # module Converters
end # module Poleica
