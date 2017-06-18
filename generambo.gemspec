# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'generambo/version'

Gem::Specification.new do |spec|
  spec.name          = 'generambo'
  spec.version       = Generambo::VERSION
  spec.authors       = ['Vadim Stroganov']
  spec.email         = ['vadimstroganov@gmail.com']

  spec.summary       = 'Advanced code generator for Android projects with a nice and flexible template system.'
  spec.description   = 'Generambo is a powerful and easy-to-use Android code generator.'
  spec.homepage      = 'https://github.com/vadimstroganov/generambo'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  # spec.bindir        = 'bin'
  spec.executables   = ['generambo']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '0.19.4'
  spec.add_runtime_dependency 'liquid', '4.0.0'
  spec.add_runtime_dependency 'colorize', '0.8.1'
  spec.add_runtime_dependency 'git', '1.3.0'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
end
