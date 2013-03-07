module ActiveResource
  class Base
    class << self
      def cache_key(*arguments)
        ([get_url, element_name]+arguments.reject(&:nil?).collect{|arg| arg.to_s.strip}).reject(&:blank?).join('-')
      end
      
      alias :old_find :find
      def find(*arguments)
        begin
          key = cache_key(*arguments)
          cache = Rails.cache.fetch(key)
          if cache.nil?
            obj = old_find(*arguments)
            Rails.cache.write(key, obj.instance_of?(Array) ? obj : obj.to_xml, :expires_in => 1.day) if !obj.nil?
          else
            obj = cache.instance_of?(String) ? self.new.from_xml(cache) : cache
          end
          return obj
        rescue ActiveResource::TimeoutError, ActiveResource::ResourceNotFound, ActiveResource::ServerError
          return nil
        end
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