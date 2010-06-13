module ActiveResource
  module Extensions
    module URL
      def self.included(base)
        base.class_eval do
          include InstanceMethods
          extend ClassMethods
        end
      end

      module InstanceMethods
        def get_url(method_name, options = {})
          self.class.prefix_for_url + "#{self.class.prefix}#{self.class.collection_name}/#{id}/#{method_name}.#{options[:format] || self.class.format.extension}"
        end        
      end

      module ClassMethods
        def collection_url(options = {})
          prefix_for_url + "#{prefix}#{collection_name}.#{options[:format] || format.extension}"
        end
        
        def element_url(id, options = {})
          prefix_for_url + "#{prefix}#{collection_name}/#{id}.#{options[:format] || format.extension}"
        end
        
        def prefix_for_url
          host = site.host
          host = headers['Host'] if host=='127.0.0.1'
          "#{site.scheme}://#{host}:#{site.port}"
        end
        
        def get_url(method_name = nil, options = {})
          url = "#{self.prefix_for_url}#{self.prefix}"
          url << "#{self.collection_name}/#{method_name}" if !method_name.nil?
          format = options[:format]
          url << ".#{format}" if !format.nil?
          url
        end
      end
    end
  end
end
