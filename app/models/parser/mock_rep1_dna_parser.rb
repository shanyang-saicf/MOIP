class MockRep1DnaParser < VcfParser

  attr_accessor :repDna

  def parse(line)
    return line.squish
  end

end