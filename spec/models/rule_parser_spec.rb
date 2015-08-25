require 'rails_helper'
include ParseFactory

RSpec.describe "Parser::ParseFactory", type: :model do

  it "RULE_parser" do
    json = JSON.parse(File.read("public/rulefiles/CNV_v4dot1.json"))
    result = RuleParser.new.parseJson(json)
    expect(result[0]).to eq("SVTYPE == CNV")
    expect(result[1]).to eq("FILTER == PASS")
    expect(result[2]).to eq("CN >= 7")
    expect(result[3]["and"][0]).to eq("ID != ")
    expect(result[3]["and"][1]).to eq("ID != .")
  end

end