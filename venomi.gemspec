# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'venomi/version'

Gem::Specification.new do |spec|
  spec.name          = "venomi"
  spec.version       = Venomi::VERSION
  spec.authors       = ["Alexandr Turchyn"]
  spec.email         = ["lexfox777@gmail.com"]

  spec.summary       = 'United I18n backend simple with mongoid provider.'
  spec.description   = 'United I18n backend simple with mongoid provider and adds translation functionality to Rails Admin.'
  spec.homepage      = "https://github.com/AlexandrToorchyn/venomi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'rspec', '~> 3.4.0'
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'bundler', '~> 1.7'
  spec.add_dependency 'rails_admin', '~> 1.0'
  spec.add_dependency 'mongoid'
  spec.add_dependency 'rails-i18n'
end
