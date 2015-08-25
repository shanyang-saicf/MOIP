require 'rails_helper'
require 'less_than'

RSpec.describe "RuleInterpreter::LessThan", type: :model do
@line = {}

it "these should be less than" do
  @line = { "Jody" => "friendly",
            "Details" => { "Cats" => "3", "YearsWorked" => "1.2"}
  }
  expect(LessThan.new("YearsWorked", "1.3").evaluate(@line)).to be true
  expect(LessThan.new("Cats", "4").evaluate(@line)).to be true
end

it "these should not be less than" do
  @line = { "Jody" => "friendly",
            "Details" => { "Cats" => "3", "YearsWorked" => "1.2"}
  }
  expect(LessThan.new("Cats", "3").evaluate(@line)).to be false
end

it "these don't exist" do
  @line = { "Jody" => "friendly",
            "Details" => { "Cats" => "3", "YearsWorked" => "1.2"}
  }
  expect(LessThan.new("Mike", "").evaluate(@line)).to be false
  expect(LessThan.new("", "").evaluate(@line)).to be false
  expect(LessThan.new("", "4").evaluate(@line)).to be false
end

it "line is null" do
  @line = nil
  expect(LessThan.new("", "").evaluate(@line)).to be nil
  expect(LessThan.new("", nil).evaluate(@line)).to be nil
  expect(LessThan.new(nil, nil).evaluate(@line)).to be nil
  expect(LessThan.new(nil, "").evaluate(@line)).to be nil
end
end
