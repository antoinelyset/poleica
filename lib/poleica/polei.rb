# -*- encoding: utf-8 -*-
module Poleica
  # Strange name for a simple object, it represents a File
  class Polei
    include Poleica::Typeable
    include Poleica::Convertible

    attr_reader :path, :name

    def initialize(path)
      @path = path.strip
    end

    def name
      File.basename(path, File.extname(path))
    end
  end # class Polei
end # module Poleica