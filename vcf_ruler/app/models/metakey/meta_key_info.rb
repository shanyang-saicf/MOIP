class MetaKeyInfo < MetaKey

  attr_accessor :number, :type, :description

  def initialize(line)
    array = line_formatter(line)
    @id = array[0].match("=").post_match
    @number = array[1].match("=").post_match
    @type = array[2].match("=").post_match
    @description = array[3].match("=").post_match
  end

  private


end