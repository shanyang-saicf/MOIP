class LessThan < Expression

  def initialize(expression1, expression2, *expression3)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate
    if (@expression1.is_a? String) && (@expression2.is_a? String)
      return @expression1 < @expression2
    else
      return  @expression1.evaluate < @expression2.evaluate
    end
  end

end