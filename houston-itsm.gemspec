$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "houston/itsm/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "houston-itsm"
  s.version     = Houston::Itsm::VERSION
  s.authors     = ["Bob Lail"]
  s.email       = ["bob.lail@cph.org"]
  s.homepage    = "https://github.com/concordia-publishing-house/houston-itsm"
  s.summary     = "Module for Houston that displays ITSMs"
  s.description = "Module for Houston that displays ITSMs"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.3"
  s.add_dependency "ruby-ntlm"

  s.add_development_dependency "sqlite3"
end
