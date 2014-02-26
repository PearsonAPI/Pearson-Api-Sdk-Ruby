# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pearson/version'

Gem::Specification.new do |spec|
  spec.name          = "pearson_sdk"
  spec.version       = Pearson::VERSION
  spec.authors       = ["Pearson, Andrew Cantino"]
  spec.email         = ["andrew@beelinereader.com"]
  spec.description   = %q{A Ruby Client Library for accessing the Pearson API}
  spec.homepage      = "https://developer.pearson.com/apis/"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "activesupport"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
