class Or < Expression

  def initialize(expression)
    if expression.is_a? Array
      @expression = expression
    else
      raise 'Expected Array value'
    end

  end

  def evaluate(line)
    begin
      if @expression.all? { |x| x.is_a? Boolean }
        return applyLogic(@expression)
      else
        return applyLogic(@expression.collect { | x | x.evaluate(line) })
      end
    rescue
      return nil
    end
  end

  def applyLogic(expression)
    if !expression.select { |n| n == true}.empty?
      return true
    else
      return false
    end
  end
end