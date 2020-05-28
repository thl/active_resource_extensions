module ActiveResource
  class Connection
    alias :old_get :get
    
    def get(path, headers = {})
      cache_key = site.host
      cache_key = cache_key.nil? ? path : File.join(cache_key, path)
      body = Rails.cache.read(cache_key)
      if body.nil?
        resp = self.old_get(path, headers)
        Rails.cache.write(cache_key, resp.body, :expires_in => 1.day)
        return resp
      else
        return HttpWrapper.new(body)
      end
    end
  end
end