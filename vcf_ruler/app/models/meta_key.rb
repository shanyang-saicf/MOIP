class MetaKey
  
  attr_accessor :id

  def initialize(line)
    @id = line_breaker(line)
  end


  private

  def line_breaker(line)
    line.match("##").post_match.match("=").pre_match
  end
end