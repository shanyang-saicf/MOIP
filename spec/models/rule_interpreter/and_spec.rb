require 'rails_helper'
require 'and'

RSpec.describe "RuleInterpreter::And", type: :model do

  it "true and true returns true" do
    expect(And.new([true, true]).evaluate("tester")).to be true
  end

  it "true and false returns false" do
    expect(And.new([true, false]).evaluate("tester")).to be false
  end

  it "false and true returns false" do
    expect(And.new([false, true]).evaluate("tester")).to be false
  end

  it "false and false returns false" do
    expect(And.new([false, false]).evaluate("tester")).to be false
  end

  it "null and null return error?" do
    expect(And.new([nil, nil]).evaluate("tester")).to be nil
  end

end
