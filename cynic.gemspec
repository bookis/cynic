# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cynic/version'

Gem::Specification.new do |spec|
  spec.name          = "cynic"
  spec.version       = Cynic::VERSION
  spec.authors       = ["Bookis Smuin"]
  spec.email         = ["bookis.smuin@gmail.com"]
  spec.description   = %q{A Lightweight Rack-based framework}
  spec.summary       = %q{Cynic provides a framework with a few tools built on the ideas of rails.}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_runtime_dependency "rack"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
