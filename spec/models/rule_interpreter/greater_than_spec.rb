require 'rails_helper'
require 'greater_than'

RSpec.describe "RuleInterpreter::GreaterThan", type: :model do
  @line = {}

  it "these should be greater than" do
    @line = { "Jody" => "friendly",
              "Details" => { "Cats" => "3", "YearsWorked" => "1.2"}
    }
    expect(GreaterThan.new("YearsWorked", "1.1").evaluate(@line)).to be true
    expect(GreaterThan.new("Cats", "2").evaluate(@line)).to be true
  end

  it "these should not be greater than" do
    @line = { "Jody" => "friendly",
              "Details" => { "Cats" => "3", "YearsWorked" => "1.2"}
    }
    expect(GreaterThan.new("Cats", "3").evaluate(@line)).to be false
  end

  it "these don't exist" do
    @line = { "Jody" => "friendly",
              "Details" => { "Cats" => "3", "YearsWorked" => "1.2"}
    }
    expect(GreaterThan.new("Mike", "").evaluate(@line)).to be false
    expect(GreaterThan.new("", "").evaluate(@line)).to be false
    expect(GreaterThan.new("", "4").evaluate(@line)).to be false
  end

  it "line is null" do
    @line = nil
    expect(GreaterThan.new("", "").evaluate(@line)).to be nil
    expect(GreaterThan.new("", nil).evaluate(@line)).to be nil
    expect(GreaterThan.new(nil, nil).evaluate(@line)).to be nil
    expect(GreaterThan.new(nil, "").evaluate(@line)).to be nil
  end

end
