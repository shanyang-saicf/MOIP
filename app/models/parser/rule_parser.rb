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
      # p value
      deep_transverse(value)
    end
    p @rules
  end


  def deep_transverse(object)
    if object.is_a? String
      # p object
    else
      object.each { |key, value |
        # p "#{key}....#{value}"
        if value.is_a? Hash
          @rules[@count] = key +  hashBreaker(value)
          @count = @count+1
        elsif value.is_a? Array
          @rules[@count] = arrayBreaker(key, value)
          @count = @count+1
          # deep_transverse(value)
        else
          deep_transverse(key)
        end
      }
    end
  end

  def arrayBreaker(condition, array)
    modifiedArray = []
    currentCount = 0
    array.each do | value |
      value.each_key { | key |
        if value[key].is_a? Array
          modifiedArray[currentCount] = arrayBreaker(key, value[key])
          currentCount = currentCount+1
        else
          modifiedArray[currentCount] = key + hashBreaker(value[key])
          currentCount = currentCount+1
        end
      }
    end
    sentence = {condition => modifiedArray}
    return sentence
  end

  def hashBreaker(hash)
    sentence = ""
    hash.each do | key, value |
      if !value.nil?
        sentence = sentence + " " + value
      end
    end
    return sentence
  end

end