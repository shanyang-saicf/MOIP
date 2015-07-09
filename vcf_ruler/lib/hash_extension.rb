class Hash
  def deep_find(key, value, object=self, found=nil)
    if object.respond_to?(:key?) && object.key?(key) && object.has_value?(value)
      return object[key]
    elsif object.is_a? Enumerable
      object.find {| *a | found = deep_find(key, value, a.last) }
      return found
    end
  end
end