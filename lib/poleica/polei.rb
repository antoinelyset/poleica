# -*- encoding: utf-8 -*-
module Poleica
  # Strange name for a simple object, it represents a File
  class Polei
    include Poleica::Typeable
    include Poleica::Pathable
    include Poleica::Convertible

    attr_reader :path, :name

    def initialize(path)
      @path = path.strip
      raise "No file @ #{path}" unless File.exists?(path)
    end

    def name
      File.basename(path, File.extname(path))
    end
  end # class Polei
end # module Poleica
