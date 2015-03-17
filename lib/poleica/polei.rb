# -*- encoding: utf-8 -*-
module Poleica
  # Strange name for a simple object, it represents a File
  class Polei
    include Poleica::Typeable
    include Poleica::Pathable
    include Poleica::Convertible

    attr_reader :path

    def initialize(path)
      @path = path.strip
      fail "No file @ #{path}" unless File.exist?(path)
    end
  end # class Polei
end # module Poleica
