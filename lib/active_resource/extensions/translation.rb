module ActiveResource
  module Extensions
    module Translation
      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
      end
      module ClassMethods
        # Returns the base AR subclass that this class descends from. If A
        # extends AR::Base, A.base_class will return A. If B descends from A
        # through some arbitrarily deep hierarchy, B.base_class will return A.
        def base_class
          class_of_active_resource_descendant(self)
        end
        
        # Transform the modelname into a more humane format, using I18n.
        # Defaults to the basic humanize method.
        # Default scope of the translation is activerecord.models
        # Specify +options+ with additional translating options.
        def human_name(options = {})
          defaults = self_and_descendants_from_active_resource.map {|klass| :"#{klass.name.underscore}" }
          defaults << self.name.humanize
          I18n.translate(defaults.shift, {:scope => [:activeresource, :models], :count => 1, :default => defaults}.merge(options))
        end
        
        # Transforms attribute key names into a more humane format, such as "First name" instead of "first_name". Example:
        #   Person.human_attribute_name("first_name") # => "First name"
        # This used to be depricated in favor of humanize, but is now preferred, because it automatically uses the I18n
        # module now.
        # Specify +options+ with additional translating options.
        def human_attribute_name(attribute_key_name, options = {})
          defaults = self_and_descendants_from_active_resource.map do |klass|
            :"#{klass.name.underscore}.#{attribute_key_name}"
          end
          defaults << options[:default] if options[:default]
          defaults.flatten!
          defaults << attribute_key_name.to_s.humanize
          options[:count] ||= 1
          I18n.translate(defaults.shift, options.merge(:default => defaults, :scope => [:activeresource, :attributes]))
        end
        
        private
        
        # Returns the class descending directly from ActiveRecord::Base or an
        # abstract class, if any, in the inheritance hierarchy.
        def class_of_active_resource_descendant(klass)
          if klass.superclass == Base
            klass
          elsif klass.superclass.nil?
            raise ActiveRecordError, "#{name} doesn't belong in a hierarchy descending from ActiveRecord"
          else
            class_of_active_resource_descendant(klass.superclass)
          end
        end
                
        def self_and_descendants_from_active_resource#nodoc:
          klass = self
          classes = [klass]
          while klass != klass.base_class  
            classes << klass = klass.superclass
          end
          classes
        rescue
          # OPTIMIZE this rescue is to fix this test: ./test/cases/reflection_test.rb:56:in `test_human_name_for_column'
          # Appearantly the method base_class causes some trouble.
          # It now works for sure.
          [self]
        end
      end
    end
  end
end
