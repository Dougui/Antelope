require 'spec_helper'

describe UserSession do
  setup :activate_authlogic

  before(:each) do
    @userSession = UserSession.new
  end
  it "must be unpersitent" do
    @userSession.persisted?.should == false
  end
end
