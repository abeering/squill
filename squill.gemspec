# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'squill/version'

Gem::Specification.new do |spec|
  spec.name          = "squill"
  spec.version       = Squill::VERSION
  spec.authors       = ["Andy Beering"]
  spec.email         = ["andy.beering@gmail.com"]
  spec.summary       = %q{Simple CLI tool for storing, searching and executing ad-hoc SQL.}
  spec.description   = %q{Simple CLI tool for storing, searching and executing ad-hoc SQL.}
  spec.homepage      = "https://github.com/abeering/squill"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
