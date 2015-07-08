class Or < Expression

  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(line)
    result = @expression1.evaluate(line)
    result2 = @expression2.evaluate(line)
    (result + result2)
  end

end