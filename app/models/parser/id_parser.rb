class IdParser < ParseFactory

  attr_accessor :id

  def parse(line)
    if line.include? ";"
      data = line.split(";")
      data.each do | id |
        @id = id
      end
      return data
    end
    return line
  end

end