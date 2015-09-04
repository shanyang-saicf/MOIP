require 'rails_helper'
require_relative '../../../app/models/rule_interpreter/or'

RSpec.describe "RuleInterpreter::Or", type: :model do

  @line = {}

  it "should be null" do
    expect(Or.new([nil, nil]).evaluate(@line)).to be nil
    expect(Or.new(["", nil]).evaluate(@line)).to be nil
    expect(Or.new([nil, ""]).evaluate(@line)).to be nil
  end

  it "true or true equals true" do
    expect(Or.new([true, true]).evaluate(@line)).to be true
  end

  it "true OR false equals true" do
    expect(Or.new([true, false]).evaluate(@line)).to be true
  end

  it "false OR true equals true" do
    expect(Or.new([false, true]).evaluate(@line)).to be true
  end

  it "false OR false equals false" do
    expect(Or.new([false, false]).evaluate(@line)).to be false
  end

  it "false OR false OR false equals false" do
    expect(Or.new([false, false, false]).evaluate(@line)).to be false
  end

  it "finds a true" do
    expect(Or.new([false, false, true]).evaluate(@line)).to be true
    expect(Or.new([true, false, true]).evaluate(@line)).to be true
  end

end
