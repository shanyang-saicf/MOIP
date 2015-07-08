class Equals < Expression

  def initialize(expression1, expression2, *expression3)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(line)
    if (@expression1.is_a? String) && (@expression2.is_a? String)
      # return @expression1 = @expression2
      return line.has_value? @expression2
    else
      return  @expression1.evaluate == @expression2.evaluate
    end
  end

end