class AltParser < Parser

  attr_accessor :alt

  def parse(line)
    if line.include? ","
      data = line.split(",")
      data.each do | alt |
        @alt = alt
        end
      return data
    end
    return line
  end

end