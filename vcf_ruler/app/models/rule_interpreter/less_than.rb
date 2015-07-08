class LessThan < Expression

  def initialize(expression1, expression2, *expression3)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(line)
    return  @expression1.evaluate(line) <= @expression2.evaluate(line)
  end

end