require 'json'
class Expression

  attr_accessor :fileHashed

  def initialize(fileHashed)
    @fileHashed = fileHashed
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

  def evaluate(expression)
    expression.evaluate
  end

  def testEval(expression)
    fileHashed.each do | line |
      if expression.evaluate(line)
        p line
      end
    end
  end

end