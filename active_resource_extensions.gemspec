$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_resource_extensions/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_resource_extensions"
  s.version     = ActiveResourceExtensions::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActiveResourceExtensions."
  s.description = "TODO: Description of ActiveResourceExtensions."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'activeresource'
  s.add_dependency "rails", "~> 4.0"
  s.add_dependency 'hpricot' #, '>= 0.8.6'

  s.add_development_dependency "sqlite3"
end
