class GreaterThan < Expression

  def initialize(expression1, expression2, *expression3)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(line)
    begin
      if (@expression1.is_a? String) && (@expression2.is_a? String)
        value = line.deep_find(@expression1)
        return value.nil? ? false : value.to_f > @expression2.to_f
      else
        return  (@expression1.evaluate(line) > @expression2.evaluate(line))
      end
    rescue
      return nil
    end
  end

end