class MockRep1DnaParser < Parser

  attr_accessor :repDna

  def parse(line)
    return line.squish
  end

end