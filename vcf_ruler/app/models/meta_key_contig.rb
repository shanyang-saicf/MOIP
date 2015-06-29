
class MetaKeyContig < MetaKey

    attr_reader :length, :assembly

  def parse(line)
    array = line_breaker(line)
    @id = array[0].match("=").post_match
    @length = array[1].match("=").post_match
    @assembly = array[2].match("=").post_match
    p @id + " " + @length + " " + @assembly
  end

  private
  def line_breaker(line)
    formatedline = line.match("<").post_match.match(">").pre_match
    formatedline.split(',')
  end

end