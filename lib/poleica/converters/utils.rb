# -*- encoding: utf-8 -*-
require 'digest/md5'

module Poleica
  module Converters
    module Utils
      def path_for_extension(extension)
        "#{path_without_extension}.#{extension}"
      end

      def path_without_extension
        File.join(File.dirname(polei.path), File.basename(polei.path,".*"))
      end

      def path_with_md5_for_extention(extension)
        data   = File.read(polei.path)
        md5    = Digest::MD5.new
        digest = md5.hexdigest(data)
        "#{path_without_extension}-#{digest}.#{extension}"
      end
    end
  end
end
