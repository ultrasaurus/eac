# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eac/version'

Gem::Specification.new do |spec|
  spec.name          = "eac"
  spec.version       = Eac::VERSION
  spec.authors       = ["Sarah Allen", "Sarah Mei"]
  spec.email         = ["sarah@ultrasaurus.com", "sarahmei@gmail.com"]
  spec.summary       = %q{Enables parsing of EAC-CPF (Encoded Archival Context - Corporate Bodies, Persons, and Families) files. }
  spec.description   = %q{The initial focus is to read EAC-CPF files that represent an individual person, which will have a 'cpfDescription' node.  The 'cpfDescription' (Corporate body, person or family description) contains information on the name structures, descriptive elements, and relationships.}
  spec.homepage      = "https://github.com/ultrasaurus/eac"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "nokogiri"
end
