require 'json'


class Expression

  attr_accessor :fileHashed

  def initialize(fileHashed)
    @fileHashed = fileHashed
  end

  def filterHash(newHash)
    @fileHashed = newHash
  end

  def |(other)
    Or.new(self, other)
  end

  def &(other)
    And.new(self, other)
  end

  def gt(other)
    GreaterThan.new(self, other)
  end

  def eq(other)
    Equals.new(self, other)
  end

  def evaluate(expression, line)
    expression.evaluate(line)
  end

  def testEval(expression)
    hash = []
    fileHashed.each do | line |
      if expression.evaluate(line)
         hash << line
      end
    end
    return hash
  end


  # @expression = Expression.new(hashJson)
  # @expression.testEval(And.new(Equals.new("FXX", "0.00267019"), Not.new(Equals.new("POS", "10032611165"))))  #Same as @expression.testEval((Equals.new("FXX", "0.00267019") & Equals.new("POS", "100611165")))
  # @expression.testEval((Equals.new("POS", "100611165") & (Equals.new("transcript", "NM_000061.2"))))
  #p "123 = 123 " + @expression.evaluate(Equals.new("123", "123")).to_s
  #p "345 > 344 " + @expression.evaluate(GreaterThan.new("345", "344")).to_s
  #p "123 < 321 " + @expression.evaluate(LessThan.new("123", "321")).to_s
  #p "true || false " + @expression.evaluate(Or.new(true, false)).to_s
  #p "123 = 123 && 345 > 344 " + @expression.evaluate(Equals.new("123", "123") & GreaterThan.new("345", "344")).to_s
  #p "345 >= 344 " + @expression.evaluate(Or.new(Equals.new("345", "344"), GreaterThan.new("345", "344"))).to_s
  #p "123 != 123 " + @expression.evaluate(Not.new(Equals.new("123", "123"))).to_s
  #p "!(345 > 344 && 123 < 321) " + @expression.evaluate(Not.new(GreaterThan.new("345", "344")) & LessThan.new("123", "321")).to_s

  #p @expression.evaluate(Equals.new("FilterType", "") & GreaterThan.new("CopyNumber", "7"))

end