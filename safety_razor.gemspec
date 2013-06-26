# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'safety_razor/version'

Gem::Specification.new do |spec|
  spec.name          = "safety_razor"
  spec.version       = SafetyRazor::VERSION
  spec.authors       = ["Fletcher Nichol"]
  spec.email         = ["fnichol@nichol.ca"]
  spec.description   = %q{Safety Razor - A Ruby client for the Razor API.}
  spec.summary       = spec.description
  spec.homepage      = "http://blueboxgroup.github.io/safety_razor"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "hashie"
  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "minitest"
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'guard-minitest'

  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'guard-cane'
  spec.add_development_dependency 'tailor'
  spec.add_development_dependency 'countloc'
end
