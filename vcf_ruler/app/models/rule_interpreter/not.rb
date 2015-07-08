class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate
    if (@expression.is_a? Boolean)
      return !@expression
    else
      return  !@expression.evaluate
    end
  end

end