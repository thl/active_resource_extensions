$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_resource_extensions/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_resource_extensions"
  s.version     = ActiveResourceExtensions::VERSION
  s.authors     = ["Andres Montano"]
  s.email       = ["amontano@virginia.edu"]
  s.homepage    = "http://subjects.kmaps.virginia.edu"
  s.summary     = "Engine that extends functionality of active resource to include family tree support and additional helper methods."
  s.description = "Engine that extends functionality of active resource to include family tree support and additional helper methods."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'activeresource'
  s.add_dependency 'rails'
end
