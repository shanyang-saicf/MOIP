class FormatParser < VcfParser

  attr_accessor :format

  def initialize
    @format = []
  end

  def parse(line)
    if line.include? ":"
      data = line.split(":")
      data.each do | key |
        @format << key
      end
      return data
    end
    return [line]
  end

end