class And < Expression

  def initialize(expression1, expression2, *expression3)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(line)
    results = @expression1.evaluate(line) & @expression2.evaluate(line)
    return results
  end
end