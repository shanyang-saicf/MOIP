require 'rails_helper'
require 'and'

RSpec.describe "RuleInterpreter::And", type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "should return true" do
    expect(And.new(true, true).evaluate("tester")).to be true
  end

end
