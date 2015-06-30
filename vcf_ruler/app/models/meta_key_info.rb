class MetaKeyInfo < MetaKey

  attr_accessor :number, :type, :description

  def initialize(line)
    @id = ""
    p line
  end
end