# ActiveResourceExtensions
# Include hook code here
require 'active_resource_extensions/acts/tree'
require 'active_resource_extensions/acts/family_tree'
require 'active_resource_extensions/extensions/translation'
require 'active_resource_extensions/extensions/url'
ActiveResource::Base.send :include, ActiveResourceExtensions::Acts::Tree
ActiveResource::Base.send :include, ActiveResourceExtensions::Acts::FamilyTree
ActiveResource::Base.send :include, ActiveResourceExtensions::Extensions::URL
ActiveResource::Base.send :include, ActiveResourceExtensions::Extensions::Translation
require 'active_resource_extensions/patches/active_resource_patch'
require 'active_resource_extensions/patches/http_wrapper'
require 'active_resource_extensions/patches/connection'

module ActiveResourceExtensions
end