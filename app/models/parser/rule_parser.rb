require 'json'

class RuleParser
  include ParseFactory

  @rules
  @count

  def initialize
    @rules = []
    @count = 0
  end

  def parseJson(json)
    json.each do | key, value|
      p value
      deep_transverse(value)
    end
    p @rules
  end


  def deep_transverse(object)
    if object.is_a? String
      p object
    else
      object.each { |key, value |
        p "#{key}....#{value}"
        if value.is_a? Hash
          @rules[@count] = key +  hashBreaker(value)
          @count = @count+1
        elsif value.is_a? Array
          @count = @count+1
          deep_transverse(value)
        else
          deep_transverse(key)
        end
      }
    end
  end

  def hashBreaker(hash)
    sentence = ""
    hash.each do | key, value |
      sentence = sentence + " " + value
    end
    p sentence
    return sentence
  end

end