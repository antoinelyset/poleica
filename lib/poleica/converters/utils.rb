# -*- encoding: utf-8 -*-
require 'digest/md5'
require 'shellwords'

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

      def escape(string)
        Shellwords.shellescape(string)
      end
    end
  end
end
