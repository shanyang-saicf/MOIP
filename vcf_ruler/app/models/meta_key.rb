class MetaKey

  attr_reader :id

  def parse(line)
    @id = line_breaker(line)
  end

  private

  def line_breaker(line)
    line.match("##").post_match.match("=").pre_match
  end
end