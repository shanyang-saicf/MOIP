class MockRep1DnaParser < ParseFactory

  attr_accessor :repDna

  def parse(line)
    return line.squish
  end

end