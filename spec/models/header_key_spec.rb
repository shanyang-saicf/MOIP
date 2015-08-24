require 'rails_helper'

RSpec.describe "Headerkey::HeaderKey", type: :model do
  it "parses the header correctly" do
    line = "#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	Mock-rep1-DNA"
    headers = HeaderKey.new
    headers.fillHeader(line)
    expect(headers.headers.length).to eq(10)
    expect(headers.headers[0]).to eq("CHROM")
    expect(headers.headers[9]).to eq("Mock-rep1-DNA")
  end
end
