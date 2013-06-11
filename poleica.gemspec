# -*- encoding: utf-8 -*-
require File.expand_path('../lib/poleica/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'poleica'
  s.version     = Poleica::VERSION
  s.date        = '2013-06-17'
  s.summary     = 'Create PNG from files (docs, images)'
  s.description = 'Create PNG from files (docs, images)'
  s.authors     = ['Antoine Lyset']
  s.email       = 'antoinelyset@gmail.com'
  s.homepage    = 'https://0.0.0.0'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'guard-minitest'
  s.add_development_dependency 'pry-plus'
end