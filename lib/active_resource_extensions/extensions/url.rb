module ActiveResourceExtensions
  module Extensions
    module URL
      extend ActiveSupport::Concern
      
      included do
      end
      
      def get_url(method_name = nil, **options)
        str = "#{self.class.prefix_for_url}#{self.class.prefix}#{self.class.collection_name}/#{id}#{'/' + method_name.to_s if !method_name.blank?}"
        if options[:format].nil?
          str << ".#{self.class.format.extension}"
        else
          str << ".#{options[:format]}" if !options[:format].blank?
        end
        str
      end
      
      class_methods do
        def collection_url(**options)
          prefix_for_url + "#{prefix}#{collection_name}.#{options[:format] || format.extension}"
        end
        
        def prefix_for_url
          prefix = "#{site.scheme}://#{site.host}"
          prefix << ":#{site.port}" if site.port!=80
          prefix
        end
        
        def service
          site.host.gsub('.', '_')
        end
        
        def get_url(method_name = nil, **options)
          url = "#{self.prefix_for_url}#{self.prefix}"
          url << "#{self.collection_name}/#{method_name}" if !method_name.nil?
          format = options[:format]
          url << ".#{format}" if !format.nil?
          url
        end
        
        def get_url_template(method_name = nil, **options)
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