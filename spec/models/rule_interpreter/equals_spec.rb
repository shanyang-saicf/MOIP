require 'rails_helper'
require 'equals'

RSpec.describe "RuleInterpreter::Equals", type: :model do

  @line = {}

  it "these should equal" do
    @line = { "Jody" => "friendly",
              "Details" => { "Cats" => "3", "YearsWorked" => "1.2"}
    }
    expect(Equals.new("Jody", "friendly").evaluate(@line)).to be true
    expect(Equals.new("Cats", "3").evaluate(@line)).to be true
  end

  it "these should not equal" do
    @line = { "Jody" => "friendly",
              "Details" => { "Cats" => "3", "YearsWorked" => "1.2"}
    }
    expect(Equals.new("Details", "Cats").evaluate(@line)).to be false
    expect(Equals.new("YearsWorked", "2.1").evaluate(@line)).to be false
    expect(Equals.new("Jody", "friend").evaluate(@line)).to be false
  end

  it "these don't exist" do
    @line = { "Jody" => "friendly",
              "Details" => { "Cats" => "3", "YearsWorked" => "1.2"}
    }
    expect(Equals.new("Mike", "").evaluate(@line)).to be false
    expect(Equals.new("", "").evaluate(@line)).to be false
  end

  it "line is null" do
    @line = nil
    expect(Equals.new("", "").evaluate(@line)).to be nil
    expect(Equals.new("", nil).evaluate(@line)).to be nil
    expect(Equals.new(nil, nil).evaluate(@line)).to be nil
    expect(Equals.new(nil, "").evaluate(@line)).to be nil
  end

end
