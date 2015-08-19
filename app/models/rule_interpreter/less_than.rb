class LessThan < Expression

  def initialize(expression1, expression2, *expression3)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(line)
    if (@expression1.is_a? String) && (@expression2.is_a? String)
      value = line.deep_find(@expression1)
      return value.nil? ? false : value < @expression2
    else
      return  (@expression1.evaluate(line) < @expression2.evaluate(line))
    end
  end

end