# ActiveResourceExtensions
# Include hook code here
require 'active_resource_extensions/acts/tree'
require 'active_resource_extensions/extensions/translation'
require 'active_resource_extensions/extensions/url'
ActiveResource::Base.send :include, ActiveResourceExtensions::Acts::Tree
ActiveResource::Base.send :include, ActiveResourceExtensions::Extensions::URL
ActiveResource::Base.send :include, ActiveResourceExtensions::Extensions::Translation
# Using hpricot. require 'hpricot' no longer needed as this is done automatically by rails 3 in Gemfile.
require 'active_resource_extensions/patches/traverse'
require 'active_resource_extensions/patches/active_resource_patch'

module ActiveResourceExtensions
end