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
          prefix = "#{site.scheme}://#{host}"
          prefix << ":#{site.port}" if site.port!=80
          prefix
        end
        
        def get_url(method_name = nil, options = {})
          url = "#{self.prefix_for_url}#{self.prefix}"
          url << "#{self.collection_name}/#{method_name}" if !method_name.nil?
          format = options[:format]
          url << ".#{format}" if !format.nil?
          url
        end
        
        def get_url_template(method_name = nil, options ={})
          url = "#{self.prefix_for_url}#{self.prefix}"
          url << "#{self.collection_name}/{id}/"
          url << "#{method_name}" if !method_name.nil?
          format = options[:format]
          url << ".#{format}" if !format.nil?
          url
        end
        
        def link_to_remote(name, options = {}, html_options = {})
          html_options.merge!({:href => url_for(options[:url])}) if ( html_options[:href].nil? || html_options[:href].blank? ) && !options[:url].blank?
          link_to_function(name, remote_function(options), html_options || options.delete(:html))
        end
      end
    end
  end
end
