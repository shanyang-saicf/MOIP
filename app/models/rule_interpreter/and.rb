class And < Expression

  def initialize(expression1, expression2, *expression3)
    @expression1 = expression1
    @expression2 = expression2
    @expression3 = expression3
  end

  def evaluate(line)
    if (@expression1.is_a? Boolean) && (@expression2.is_a? Boolean)
      return @expression1 && @expression2
    else
      return (@expression1.evaluate(line) && @expression2.evaluate(line))
    end
  end
end

# And.new(Equals.new("FilterType", "PASS"), Not.new(Equals.new("Identifier", "COSM250061")))