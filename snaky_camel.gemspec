# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snaky_camel/version'

Gem::Specification.new do |spec|
  spec.name          = "snaky_camel"
  spec.version       = SnakyCamel::VERSION
  spec.authors       = ["Pavel Metelev"]
  spec.email         = ["pavelmetelev@gmail.com"]

  spec.summary       = %q{Automatically convert request param keys to snake_case and response keys to camelCase for Rails}
  spec.description   = %q{Rack middleware for Rails that automatically converts request param keys to snake_case and response keys to camelCase helping you maintain a consistent code style in your Ruby and JavaScript code}
  spec.homepage      = "https://github.com/p4sh4/humps-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.0"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
