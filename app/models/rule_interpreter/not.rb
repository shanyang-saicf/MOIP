class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(line)
    if (@expression.is_a? Boolean)
      return !@expression
    else
      return  !@expression.evaluate(line)
    end
  end

end