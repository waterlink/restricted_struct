# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restricted_struct'

Gem::Specification.new do |spec|
  spec.name          = "restricted_struct"
  spec.version       = RestrictedStruct::VERSION
  spec.authors       = ["Alexey Fedorov", "Anselm Helbig"]
  spec.email         = ["alexey.fedorov@wimdu.com", "anselm.helbig@wimdu.com"]
  spec.summary       = %q{Create Struct-s with private or protected attributes. Reduce your boilerplate code to nothing}
  spec.description   = %q{This gem allows to use ruby's Struct, but automatically hides all the attributes as private or protected, which provides higher level of encapsulation.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
