module ActiveResourceExtensions
  module Extensions
    module URL
      extend ActiveSupport::Concern
      
      included do
      end
      
      def get_url(method_name = nil, options = {})
        str = "#{self.class.prefix_for_url}#{self.class.prefix}#{self.class.collection_name}/#{id}#{'/' + method_name.to_s if !method_name.blank?}"
        if options[:format].nil?
          str << ".#{self.class.format.extension}"
        else
          str << ".#{options[:format]}" if !options[:format].blank?
        end
        str
      end        

      module ClassMethods
        def collection_url(options = {})
          prefix_for_url + "#{prefix}#{collection_name}.#{options[:format] || format.extension}"
        end
        
        def element_url(id, options = {})
          prefix_for_url + "#{prefix}#{collection_name}/#{id}.#{options[:format] || format.extension}"
        end
        
        def host_name
          host = site.host
          host = headers['Host'] if host=='127.0.0.1'
          host
        end
        
        def prefix_for_url
          prefix = "#{site.scheme}://#{host_name}"
          prefix << ":#{site.port}" if site.port!=80
          prefix
        end
        
        def service
          host_name.gsub('.', '_')
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
      end
    end
  end
end