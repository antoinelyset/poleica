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
  s.files       = Dir[
                    'poleica.gemspec',
                    'vendor/**/*',
                    'lib/**/*',
                    'LICENSE',
                    'README'
                  ]
  s.homepage    = 'https://0.0.0.0'
end