class MockRep1DnaParser < VcfParser

  attr_accessor :repDna

  def initialize
    @repDna = []
  end

  def parse(line)
    if line.include? ":"
      data = line.split(":").squish
      data.each do | formatData |
        @repDna << formatData
      end
      return data
    end
    return line.squish
  end

end