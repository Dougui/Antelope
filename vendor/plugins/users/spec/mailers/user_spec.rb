require "spec_helper"

describe User do
  describe "activation" do
    before(:each) do
      clean_and_create_user
    end
    let(:mail) { UserMailer.activation(@user) }

    it "renders the headers" do
      mail.to.should eq([@user.email])
      mail.from.should eq(["guirec.corbel@gmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Bonjour #{@user}")
      mail.body.encoded.should match("http://localhost:3000/user_activates/new?")
      mail.body.encoded.should match("id=#{@user.perishable_token}")
    end
  end

  describe "reset_password" do
    before(:each) do
      clean_and_create_user
    end

    let(:mail) { UserMailer.reset_password(@user) }

    it "renders the headers" do
      mail.to.should eq([@user.email])
      mail.from.should eq(["guirec.corbel@gmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Bonjour #{@user}")
      mail.body.encoded.should match("http://localhost:3000/user_password_resets/edit?")
      mail.body.encoded.should match("id=#{@user.perishable_token}")
    end
  end

end
