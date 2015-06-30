
class MetaKeyContig < MetaKey

    attr_accessor :length, :assembly

  def initialize(line)
    array = line_breaker(line)
    @id = array[0].match("=").post_match
    @length = array[1].match("=").post_match
    @assembly = array[2].match("=").post_match
  end

  private
  def line_breaker(line)
    formatedline = line.match("<").post_match.match(">").pre_match
    formatedline.split(',')
  end

end