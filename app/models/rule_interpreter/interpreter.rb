require 'expression'
require 'or'
require 'and'

class Interpreter

  # ["FilterType == PASS", "CopyNumber >= 7", {"and"=>["Identifier != ", "Identifier != ."]}]

  def interpret(sentenceArray)
    sentenceArray.each do | aSentence |
      if aSentence.include? "and"
        otherArray = []
        count = 0
        aSentence["and"].each do | sentence |
          otherArray[count] = logicCase(sentence)
          count = count+1
        end
        p And.new(otherArray[0], otherArray[1], otherArray[2])
      elsif aSentence.include? "or"
        p "TODO"
      else
        logicCase(aSentence)
      end
    end
  end

  def logicCase(sentence)
    case
      when sentence.match("==")
        otherArray = sentence.split("==")
        Equals.new(otherArray[0].squish, otherArray[1].squish)
      when sentence.match(">=")
        otherArray = sentence.split(">=")
        Or.new(Equals.new(otherArray[0].squish, otherArray[1].squish), GreaterThan.new(otherArray[0].squish, otherArray[1].squish))
      when sentence.match("!=")
        otherArray = sentence.split("!=")
        Not.new(Equals.new(otherArray[0].squish, otherArray[1].squish))
      else
        p "Nothing found"
    end
  end

end