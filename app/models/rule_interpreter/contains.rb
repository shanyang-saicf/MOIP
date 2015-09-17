class Contains < Expression

  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(line)
    begin
      if (@expression1.is_a? String) && (@expression2.is_a? String)
        value = line.deep_find(@expression1)
        return (value.nil? ? false : value.include?(@expression2))
      else
        return  (@expression1.evaluate).include?(@expression2.evaluate)
      end
    rescue
      return nil
    end
  end

end