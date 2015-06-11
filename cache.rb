require 'rubygems'

class Cache

  @data = Hash.new

  def self.store(key, value)
    @data.store(key, value)
  end

  def self.read(key)
    if value = @data[key]
      value
    end
  end

end