class MetaKeyAlt < MetaKey

  attr_accessor :description

  def initialize(line)
    array = line_formatter(line)
    @id = array[0].match("=").post_match
    @description = array[1].match("=").post_match
  end

  private
end