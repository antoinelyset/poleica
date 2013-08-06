# -*- encoding: utf-8 -*-
module Poleica
  # Configuration class
  class Configuration
    attr_accessor :timeout

    def initialize
      self.timeout = 120
    end
  end

  def self.configure
    yield(configuration) if block_given?
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end # module Poleica
