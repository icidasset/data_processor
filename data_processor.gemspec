# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "data_processor/version"

Gem::Specification.new do |spec|
  spec.name          = "data_processor"
  spec.version       = DataProcessor::VERSION
  spec.authors       = ["Steven Vandevelde"]
  spec.email         = ["icid.asset@gmail.com"]
  spec.summary       = %q{Parse YAML and Markdown files, manipulate their data and convert it to JSON}
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "redcarpet", "~> 3.1.2"
  spec.add_runtime_dependency "oj", "~> 2.10.2"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
