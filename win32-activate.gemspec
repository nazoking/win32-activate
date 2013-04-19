# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'win32/activate/version'

Gem::Specification.new do |spec|
  spec.name          = "win32-activate"
  spec.version       = Win32::Activate::VERSION
  spec.authors       = ["nazoking"]
  spec.email         = ["nazoking@gmail.com"]
  spec.description   = %q{activate window by process id}
  spec.summary       = %q{activate window by process id}
  spec.homepage      = "https://github.com/nazoking/win32-activate"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
