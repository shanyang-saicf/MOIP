require 'rails_helper'
require 'not'

RSpec.describe "RuleInterpreter::Not", type: :model do

  @line = {}

  it "should be null" do
    expect(Not.new(nil).evaluate(@line)).to be nil
  end

  it "should be true when false" do
    expect(Not.new(false).evaluate(@line)).to be true
  end

  it "shold be false when true" do
    expect(Not.new(true).evaluate(@line)).to be false
  end

end
