module ActiveResource
  class Base
    class << self
      def cache_key(*arguments)
        ([get_url, element_name]+arguments.reject(&:nil?).collect{|arg| arg.to_s.strip}).reject(&:blank?).join('-')
      end
      
      alias :old_find :find
      def find(*arguments)
        begin
          return Rails.cache.fetch(cache_key(*arguments), :expires_in => 1.hour) { old_find(*arguments) }
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