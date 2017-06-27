# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_phpipam/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_phpipam"
  spec.version       = RubyPhpipam::VERSION
  spec.authors       = ["Amin Arria"]
  spec.email         = ["arria.amin@gmail.com"]

  spec.summary       = "Ruby wrapper for the phpipam API"
  spec.description   = "Ruby wrapper for the phpipam API"
  spec.homepage      = "https://github.com/AminArria/ruby_phpipam"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
end
