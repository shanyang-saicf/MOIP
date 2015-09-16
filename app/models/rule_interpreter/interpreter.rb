require 'or'
require 'and'

class Interpreter

  def interpret(sentenceArray)
    testArray = []
    count = 0
    sentenceArray.each do | aSentence |
      if aSentence.include? "and"
        testArray[count] = andBuilder(aSentence)
        count = count+1
      elsif aSentence.include? "or"
        testArray[count] = orBuilder(aSentence)
        count = count+1
      else
        testArray[count] = logicCase(aSentence)
        count = count+1
      end
    end
    testArray
  end

  def enumerableDivider(object)
    enumArray = []
    if object.is_a? Hash
      object.each_key { |key |

        if key == "and"
          enumArray << andBuilder(object)
          break
        elsif key == "or"
          enumArray << orBuilder(object)
          break
        end

        if object[key].is_a? String
          enumArray << logicCase(object[key])
        elsif object[key].is_a? Array
          enumArray << arrayDivider(object[key])
        end
      }
    end
    return enumArray
  end

  def arrayDivider(object)
    placeHolder = []
    if object.is_a? Array
      object.each do | arrayObject |
        if arrayObject.is_a? String
          placeHolder << logicCase(arrayObject)
        elsif arrayObject.is_a? Hash
          placeHolder << enumerableDivider(arrayObject)
        end
      end
    end
    return placeHolder
  end

  def orBuilder(aSentence)
    otherArray = []
    count = 0
    aSentence["or"].each do | sentence |
      if sentence.is_a? String
        otherArray[count] = logicCase(sentence)
        count = count+1
      elsif sentence.is_a? Array
        otherArray[count] = arrayDivider(sentence)
        count = count+1
      elsif sentence.is_a? Hash
        otherArray[count] = enumerableDivider(sentence)
        count = count+1
      end
    end
    Or.new(otherArray)
  end

  def andBuilder(aSentence)
    otherArray = []
    count = 0
    aSentence["and"].each do | sentence |
      if sentence.is_a? String
        otherArray[count] = logicCase(sentence)
        count = count+1
      elsif sentence.is_a? Array
        otherArray[count] = arrayDivider(sentence)
        count = count+1
      elsif sentence.is_a? Hash
        otherArray[count] = enumerableDivider(sentence)
        count = count+1
      end
    end
    And.new(otherArray)
  end

  def logicCase(sentence)
    case
      when sentence.match("==")
        otherArray = sentenceSplitter(sentence, "==")
        Equals.new(otherArray[0], otherArray[1])
      when sentence.match("!=")
        otherArray = sentenceSplitter(sentence, "!=")
        Not.new(Equals.new(otherArray[0].squish, otherArray[1].squish))
      when sentence.match(">=")
        otherArray = sentenceSplitter(sentence, ">=")
        Or.new([Equals.new(otherArray[0], otherArray[1]), GreaterThan.new(otherArray[0], otherArray[1])])
      when sentence.match("<=")
        otherArray = sentenceSplitter(sentence, ">=")
        Or.new([Equals.new(otherArray[0], otherArray[1]), LessThan.new(otherArray[0], otherArray[1])])
      when sentence.match(">")
        otherArray = sentenceSplitter(sentence, ">")
        GreaterThan.new(otherArray[0], otherArray[1])
      when sentence.match("<")
        otherArray = sentenceSplitter(sentence, "<")
        LessThan.new(otherArray[0], otherArray[1])
      when sentence.match("contains")
        otherArray = sentenceSplitter(sentence, "contains")
        Contains.new(otherArray[0], otherArray[1])
      else
        # logger.warn "Failed to find a matching logic statement"
        false
    end
  end

  def sentenceSplitter(sentence, key)
    sentence.split(key).squish
  end

end