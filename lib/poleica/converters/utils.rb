# -*- encoding: utf-8 -*-
require 'digest/md5'

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
    end
  end
end
