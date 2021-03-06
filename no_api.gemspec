# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'no_api/version'

Gem::Specification.new do |spec|
  spec.name          = "no_api"
  spec.version       = NoApi::VERSION
  spec.authors       = ["Yuichiro Someya"]
  spec.email         = ["ayemos.y@gmail.com"]

  spec.summary       = %q{No api.}
  spec.description   = %q{No api.}
  spec.homepage      = "https://github.com/ayemos/NoApi"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency 'pry'

  spec.add_dependency 'nokogiri', '~> 1.6'
  spec.add_dependency 'mechanize', '~> 2.7'
end
