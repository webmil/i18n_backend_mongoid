# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n_backend_mongoid/version'

Gem::Specification.new do |spec|
  spec.name          = 'i18n_backend_mongoid'
  spec.version       = I18nBackendMongoid::VERSION
  spec.authors       = ['Alexandr Turchyn', 'Victor Rubych']
  spec.email         = ['lexfox777@gmail.com', 'rubych@webmil.eu']

  spec.summary       = 'United I18n backend simple with mongoid provider.'
  spec.description   = 'United I18n backend simple with mongoid provider'
  spec.homepage      = 'https://github.com/webmil/i18n_backend_mongoid'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'rspec', '~> 3.4.0'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'bundler', '~> 1.7'
  # spec.add_dependency 'rails_admin', '~> 1.0'
  spec.add_dependency 'mongoid'
  spec.add_dependency 'rails-i18n'
end
