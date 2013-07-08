# -*- encoding: utf-8 -*-
require 'digest/md5'

module Poleica
  module Converters
    # An Utility module for the converters needs to be include
    module Utils
      HOST_OS ||= (defined?('RbConfig') ? RbConfig : Config)::CONFIG['host_os']

      def path_for_extension(extension)
        "#{path_without_extension}.#{extension}"
      end

      def path_without_extension
        File.join(File.dirname(polei.path), File.basename(polei.path, '.*'))
      end

      def path_with_md5_for_extension(extension)
        data   = File.read(polei.path)
        md5    = Digest::MD5.new
        digest = md5.hexdigest(data)
        "#{path_without_extension}-#{digest}.#{extension}"
      end

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
