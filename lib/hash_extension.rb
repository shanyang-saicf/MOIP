class Hash
  def deep_find(key, object=self, found=nil)
    if object.respond_to?(:key?) && object.key?(key)
      return object[key]
    elsif object.is_a? Enumerable
      object.find {| *a | found = deep_find(key, a.last) }
      return found
    end
  end

  def <<(newHash, object=self)
    if newHash.is_a? Hash
      object.merge!(newHash)
    end
  end

  def builder(key, object=self, found=nil)
    if object.respond_to?(:key?) && object.key?(key)
      return object[key]
    elsif object.is_a? Enumerable
      object.find {| *a | found = deep_find(key, a.last) }
      return found
    end
  end

  def deep_transverse(object=self)
    object.each{ | key, value | p "#{key} = #{value}"
      if value.is_a? Enumerable
        deep_transverse(value)
      end
    }
  end
end