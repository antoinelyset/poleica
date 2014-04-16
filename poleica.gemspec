# -*- encoding: utf-8 -*-
require File.expand_path('../lib/poleica/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'poleica'
  s.version       = Poleica::VERSION
  s.license       = 'MIT'
  s.summary       = 'A general converter and thumbnail creator'
  s.description   = 'Poleica can convert docs and images to PDF and PNG, it can be extended to handle a lot of converters'
  s.authors       = ['Antoine Lyset']
  s.email         = 'antoinelyset@gmail.com'
  s.homepage      = 'https://github.com/antoinelyset/poleica'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_runtime_dependency     'childprocess'

  s.add_development_dependency 'bundler', '~> 1.3'
end
