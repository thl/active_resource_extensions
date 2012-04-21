# Include hook code here
ActiveResource::Base.send :include, ActiveResource::Acts::Tree
ActiveResource::Base.send :include, ActiveResource::Extensions::URL
ActiveResource::Base.send :include, ActiveResource::Extensions::Translation
# Using hpricot. require 'hpricot' no longer needed as this is done automatically by rails 3 in Gemfile.
require 'active_resource/patches/traverse'
require 'active_resource/patches/active_resource_patch'