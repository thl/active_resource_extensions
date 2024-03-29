module ActiveResource
  class Base
    class << self
      alias :old_find :find
      def find(*arguments)
        begin
          return old_find(*arguments)
        rescue ActiveResource::TimeoutError, ActiveResource::ResourceNotFound, ActiveResource::ServerError
          return nil
        end
      end
      
      def element_url(id, **options)
        str = prefix_for_url + "#{prefix}#{collection_name}/#{id}"
        ext = options[:format] || format.extension
        return ext.blank? ? str : [str, ext].join('.')
      end
      
      private
      
      alias :old_find_single :find_single
      # Find a single resource from the default URL
      def find_single(scope, options)
        return nil if scope.nil?
        old_find_single(scope, options)
      end      
    end
  end
end