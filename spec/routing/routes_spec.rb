require 'rails_helper'

RSpec.describe "routing to rule", :type => :routing do
  it "routes /rule/index to rule#index" do
    expect(:get => "/rule/index").to route_to(
                                              :controller => "rule",
                                              :action => "index"
                                          )
  end

  it "routes / to rule#index" do
    expect(:get => "/").to route_to(
                                         :controller => "rule",
                                         :action => "index"
                                     )
  end

  it "does not expose a list of profiles" do
    expect(:get => "/profiles").not_to be_routable
  end
end
