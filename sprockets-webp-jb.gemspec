# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sprockets/webp/version'

Gem::Specification.new do |spec|
  spec.name          = 'sprockets-webp-jb'
  spec.version       = Sprockets::WebP::VERSION
  spec.authors       = ['Max Riveiro']
  spec.email         = ['kavu13@gmail.com']
  spec.description   = %q{Sprockets converter of PNG and JPEG assets to WebP}
  spec.summary       = %q{Sprockets converter of PNG and JPEG assets to WebP}
  spec.homepage      = 'https://github.com/kavu/sprockets-webp'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'sprockets', '> 3'
  spec.add_dependency 'webp-ffi', '~> 0.2.0'
  spec.add_dependency 'fastimage', '= 2.2.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
