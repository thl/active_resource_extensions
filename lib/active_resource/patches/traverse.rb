module Hpricot
  module Traverse
    alias :old_reparent :reparent
    def reparent(nodes)
      return if nodes.nil?
      old_reparent(nodes)
    end
  end
end
