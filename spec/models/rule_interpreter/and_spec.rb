require 'rails_helper'

RSpec.describe "RuleInterpreter::And", type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "should return true" do
    And(true, true).evaluate("tester").should == true
  end

end
