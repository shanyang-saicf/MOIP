require 'or'
require 'and'

class Interpreter

  # ["FilterType == PASS", "CopyNumber >= 7", {"and"=>["Identifier != ", "Identifier != ."]}]
  # ["FilterType == PASS", "TODO >= ?", {"or"=>["Protein == ", "Protein != p.(=)"]}, {"or"=>["Function == ", {"and"=>["Function != synonymous", {"or"=>["Function contains refallele", "Function contains unknown", "Function contains missense", "Function contains nonsense", "Function contains frameshiftinsertion", "Function contains frameshiftdeletion", "Function contains nonframeshiftinsertion", "Function contains nonframeshiftdeletion", "Function contains stoploss", "Function contains frameshiftblocksubstitution", "Function contains nonframeshiftblocksubstitution"]}]}]}, {"and"=>["Location != intronic", {"or"=>[{"and"=>["Identifier != ", "Identifier != ."]}, {"and"=>["Oncominevariantclass != ", "Exxon != ", "Function != ", "Location != "]}]}]}, {"and"=>["alleleFrequency != null", "alleleFrequency >= 0.05", "alternativeObservationCount != null", "alternativeObservationCount >= 25"]}, {"or"=>[{"and"=>["Identifier != ", "Identifier != ."]}, {"and"=>["Oncominevariantclass != null", {"or"=>["Oncominevariantclass == deleterious", "Oncominevariantclass == hotspot"]}]}]}]

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

  def orBuilder(aSentence)
    otherArray = []
    count = 0
    aSentence["or"].each do | sentence |
      if sentence.is_a? String
        otherArray[count] = logicCase(sentence)
        count = count+1
      elsif sentence.is_a? Enumerable
        # interpret(sentence)
      end
    end
    Or.new(otherArray[0], otherArray[1])
  end

  def andBuilder(aSentence)
    otherArray = []
    count = 0
    aSentence["and"].each do | sentence |
      if sentence.is_a? String
        otherArray[count] = logicCase(sentence)
        count = count+1
      elsif sentence.is_a? Enumerable
        # interpret(sentence)
      end
    end
    And.new(otherArray[0], otherArray[1], otherArray[2])
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
        Or.new(Equals.new(otherArray[0], otherArray[1]), GreaterThan.new(otherArray[0], otherArray[1]))
      when sentence.match("<=")
        otherArray = sentenceSplitter(sentence, ">=")
        Or.new(Equals.new(otherArray[0], otherArray[1]), LessThan.new(otherArray[0], otherArray[1]))
      when sentence.match(">")
        otherArray = sentenceSplitter(sentence, ">")
        GreaterThan.new(otherArray[0], otherArray[1])
      when sentence.match("<")
        otherArray = sentenceSplitter(sentence, "<")
        LessThan.new(otherArray[0], otherArray[1])
      else
        p "Nothing found"
    end
  end

  def sentenceSplitter(sentence, key)
    sentence.split(key).squish
  end

end