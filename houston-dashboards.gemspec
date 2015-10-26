$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "houston/dashboards/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "houston-dashboards"
  spec.version     = Houston::Dashboards::VERSION
  spec.authors     = ["Bob Lail"]
  spec.email       = ["bob.lail@cph.org"]

  spec.summary     = "Module for Houston that displays Dashboards"
  spec.description = "Module for Houston that displays Dashboards"
  spec.homepage    = "https://github.com/concordia-publishing-house/houston-dashboards"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
  spec.test_files = Dir["test/**/*"]

  spec.add_dependency "ruby-ntlm"
  spec.add_dependency "savon", "~> 2.0"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "bundler", "~> 1.10.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "houston-core", ">= 0.5.3"
end
 