# ActiveResourceExtensions

ActiveSupport.on_load(:active_resource) do
  # Include hook code here
  require 'active_resource_extensions/patches/active_resource_patch'
  require 'active_resource_extensions/patches/http_wrapper'
  require 'active_resource_extensions/patches/connection'
  
  require 'active_resource_extensions/acts/tree'
  require 'active_resource_extensions/acts/family_tree'
  require 'active_resource_extensions/extensions/translation'
  require 'active_resource_extensions/extensions/url'
  include ActiveResourceExtensions::Acts::Tree
  include ActiveResourceExtensions::Acts::FamilyTree
  include ActiveResourceExtensions::Extensions::Translation
  include ActiveResourceExtensions::Extensions::URL
end
module ActiveResourceExtensions
end