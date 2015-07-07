
class MetaKeyContig < MetaKey

    attr_accessor :length, :assembly

  def initialize(line)
    array = line_formatter(line)
    @id = array[0].match("=").post_match
    @length = array[1].match("=").post_match
    @assembly = array[2].match("=").post_match
  end

end