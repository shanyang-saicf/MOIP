require 'rails_helper'
require 'expression'

RSpec.describe "RuleInterpreter::Expression", type: :model do
  before(:context) do
    @file = {}
    @expression = Expression.new(@file)
  end

  it "fileHashed is filled" do
    expect(@expression).to be_truthy
  end

  it "replace fileHashed" do
    newHash = {"boy" => "girl"}
    expect {@expression.filterHash(newHash)}.to change(@expression, :fileHashed).from(@file).to(newHash)
  end

  it "evaluate Not" do
    expect(@expression.evaluate(Not.new(true), @file)).to be false
    expect(@expression.evaluate(Not.new(false), @file)).to be true
  end

  it "evaluate Equals" do
    expect(@expression.evaluate(Equals.new("boy", "girl"), {"boy" => "girl"})).to be true
    expect(@expression.evaluate(Equals.new("girl", "boy"), {"boy" => "girl"})).to be false
  end

  it "evaluate NotEquals" do
    expect(@expression.evaluate(Not.new(Equals.new("boy", "girl")), {"boy" => "girl"})).to be false
  end



end
