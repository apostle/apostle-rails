# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apostle_rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'apostle-rails'
  spec.version       = ApostleRails::VERSION
  spec.authors       = ['Mal Curtis']
  spec.email         = ['mal@apostle.io']
  spec.description   = 'Rails Bindings for Apostle'
  spec.summary       = 'Easy Rails integration for Apostle'
  spec.homepage      = 'http://apostle.io'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.4'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency 'apostle'
end
