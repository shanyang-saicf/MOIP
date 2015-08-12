class RuleController < ApplicationController
  def index
    @files = Dir.glob("public/rulefiles/*.json")
  end
end
