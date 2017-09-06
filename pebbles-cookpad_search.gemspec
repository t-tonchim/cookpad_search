# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pebbles/cookpad_search/version'

Gem::Specification.new do |spec|
  spec.name          = "pebbles-cookpad_search"
  spec.version       = Pebbles::CookpadSearch::VERSION
  spec.authors       = ["tomoyuki-tanaka"]
  spec.email         = ["masuminium5@gmail.com"]

  spec.summary       = %q{Cookpad Search is sarch recipe from https://cookpad.com on command line.}
  spec.description   = %q{Usage: cpd food_name}
  spec.homepage      = "https://github.com/tomoyuki-tanaka/cookpad_search"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "nokogiri"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
