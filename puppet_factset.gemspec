# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet_factset/version'

Gem::Specification.new do |spec|
  spec.name          = "puppet_factset"
  spec.version       = PuppetFactset::VERSION
  spec.authors       = ["Geoff Williams", "Dylan Ratcliffe", "Jesse Reynolds"]
  spec.email         = ["geoff@geoffwilliams.me.uk"]

  spec.summary       = %q{Sample factsets for puppet testing. A factset is a representative sample of the set of facts for a particular OS}
  spec.homepage      = "https://github.com/GeoffWilliams/puppet_factset"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
