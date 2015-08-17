require 'json'

class RuleParser
  include ParseFactory

  @rules

  def initialize
    @rules = {}
  end

  def parseJson(json)
    json.each do | key, value|
      p value
      deep_transverse(value)
    end
    p @rules
    # end
  end


  def deep_transverse(object=self)
    if object.is_a? String
      p object
    else
      object.each { |key, value |
        p "#{key}....#{value}"
        if value.is_a? Hash
          @rules[key] = hashBreaker(value)
        elsif value.is_a? Array
          deep_transverse(value)
        else
          deep_transverse(key)
        end
      }
    end
  end

  # def deep_transverse(object=self)
  #   object.each{ | key, value |
  #     p "#{key.class} #{value.class}"
  #     if (key.is_a? String) && (value.is_a? String)
  #       # p "#{key} and #{value}"
  #       # if key.include? "Operator"
  #       #   value
  #       # elsif key.include? "Value"
  #       #   value
  #       # end
  #     elsif (key.is_a? String) && (value.is_a? Enumerable)
  #       # if value.is_a? Array
  #       #   @rules[key] = {}
  #       #   @rules[key] = deep_transverse(value)
  #       # elsif value.is_a? Hash
  #       #   deep_transverse(value)
  #       # else
  #       #   deep_transverse(value)
  #       # end
  #     elsif (key.is_a? Enumerable) && (value.nil?)
  #       deep_transverse(key)
  #     end
  #   }
  # end

  ##Think in triples!

  def hashBreaker(hash)
    sentence = ""
    hash.each do | key, value |
      sentence = sentence + " " + value
    end
    p sentence
    return sentence
  end

  def enumNull(object)
    deep_transverse(object)
  end

  def stringString(key)
    if key.include? "Operator"
      value
    elsif key.include? "Value"
      value
    end
  end

  def stringEnum(object)
    if value.is_a? Array
      @rules[key] = {}
      @rules[key] = deep_transverse(value)
    elsif value.is_a? Hash
      deep_transverse(value)
    else
      deep_transverse(value)
    end
  end

end