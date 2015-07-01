# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dredd_hooks/version'

Gem::Specification.new do |spec|
  spec.name          = "dredd_hooks"
  spec.version       = DreddHooks::VERSION
  spec.authors       = ["Adam Kliment"]
  spec.email         = ["adam@apiary.io"]
  spec.summary       = %q{Ruby Hooks Handler for Dredd API Testing Framework}
  spec.description   = %q{Write Dredd hooks in Ruby to glue together API Blueprint with your Ruby project}
  spec.homepage      = "https://github.com/apiaryio/dredd-hooks-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "aruba", "~> 0.6.2"
  spec.add_development_dependency "sinatra", "~> 1.4.5"
end
