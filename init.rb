# Include hook code here
ActiveResource::Base.send :include, ActiveResource::Acts::Tree
ActiveResource::Base.send :include, ActiveResource::Extensions::URL
ActiveResource::Base.send :include, ActiveResource::Extensions::Translation
require 'hpricot'
require 'active_resource/patches/traverse'
require 'active_resource/patches/active_resource_patch'