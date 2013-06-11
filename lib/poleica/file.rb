# -*- encoding: utf-8 -*-
module Poleica
  class File
    include Poleica::Typeable
    include Poleica::Convertible

    attr_reader :path, :name

    def initialize(path)
      @path = path.strip
    end

    def name
      File.basename(path, File.extname(path))
    end
  end # class File
end # module Poleica