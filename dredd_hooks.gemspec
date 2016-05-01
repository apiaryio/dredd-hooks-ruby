# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dredd_hooks/version'

Gem::Specification.new do |spec|
  spec.name          = "dredd_hooks"
  spec.version       = DreddHooks::VERSION
  spec.authors       = ["Adam Kliment", "Gonzalo Bulnes Guilpain"]
  spec.email         = ["adam@apiary.io", "gon.bulnes@gmail.com"]
  spec.summary       = %q{Ruby Hooks Handler for Dredd API Testing Framework}
  spec.description   = %q{Write Dredd hooks in Ruby to glue together API Blueprint with your Ruby project.}
  spec.homepage      = "https://github.com/apiaryio/dredd-hooks-ruby"
  spec.license       = "MIT"

  spec.executables   = "dredd-hooks-ruby"
  spec.files         = Dir["{bin,doc,lib}/**/*", "CHANGELOG.md", "Gemfile", "LICENSE.txt", "Rakefile", "README.md" ]
  spec.test_files    = Dir["{features,spec}/**/*"]

  spec.add_development_dependency "aruba", "~> 0.6.2"
  spec.add_development_dependency "rake", ">= 10.0", "< 12"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sinatra", "~> 1.4.5"
end
