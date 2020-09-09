# -*- encoding: utf-8 -*-
require 'date'

Gem::Specification.new do |s|
  s.name        = 'fluent-plugin-timber'
  s.version     = '2.0.1'
  s.date        = Date.today.to_s
  s.summary     = 'Timber.io plugin for Fluentd'
  s.description = 'Streams Fluentd logs to the Timber.io logging service.'
  s.authors     = ['Timber.io']
  s.email       = 'hi@timber.io'
  s.homepage    = 'https://github.com/timberio/fluent-plugin-timber'
  s.license     = 'ISC'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)

  s.add_runtime_dependency('fluentd', '>= 0.12.0', '< 2')
  s.add_runtime_dependency('http', '~> 4.0')

  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('test-unit', '~> 3.1.0')
  s.add_development_dependency('webmock', '~> 3.8')
end
