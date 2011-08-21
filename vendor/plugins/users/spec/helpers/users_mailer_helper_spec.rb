require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe UsersHelper do
  describe "helpers for a user" do
    before(:each) do
      User.destroy_all
      @user = Factory.create(:user)
    end

    it "must return a link for reset the password of a user" do
      url = url_for(:controller => :user_password_resets, :action => :edit, :id => @user.perishable_token, :only_path => false)
      helper.link_for_password_reset(@user).should == link_to(url, url)
    end

    it "must return a link for activate a user" do
      url = url_for(:controller => :user_activates, :action => :new, :id => @user.perishable_token, :only_path => false)
      helper.link_for_activate(@user).should == link_to(url, url)
    end
  end
end
