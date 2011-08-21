#encoding=utf-8
require 'spec_helper'

describe User do

  before(:each) do
    @user = Factory.build(:user)
  end

  it "must be protect for mass assignment" do
    protected_for_mass_assignment @user, :crypted_password, false
    protected_for_mass_assignment @user, :password_salt, false
    protected_for_mass_assignment @user, :persistence_token, false
    protected_for_mass_assignment @user, :active?, false
    protected_for_mass_assignment @user, :id, false
    protected_for_mass_assignment @user, :email
    protected_for_mass_assignment @user, :username
    protected_for_mass_assignment @user, :password
    protected_for_mass_assignment @user, :password_confirmation
  end

  describe "when created" do
    it "must be valid with correct arguments" do
      @user.valid?.should == true
    end

    it "must be invalid without username" do
      @user  = Factory.build(:user, :username => nil)
      @user.valid?.should == false
    end

    it "must be invalid with too short username" do
      @user  = Factory.build(:user)
      test_size 3, @user , ["username"]
    end

    it "must be invalid without email" do
      @user  = Factory.build(:user, :email => nil)
      @user.valid?.should == false
    end

    it "must be invalid with invalid email" do
      @user  = Factory.build(:user, :email => 'qqq@qqq')
      @user.valid?.should == false
    end

    it "must be invalid without password" do
      @user  = Factory.build(:user, :password => nil)
      @user.valid?.should == false
    end

    it "must be invalid with different password and password_confirmation" do
      @user  = Factory.build(:user, :password => 'aaaaaaa')
      @user.valid?.should == false
    end

    it "must be invalid with different too short password" do
      @user  = Factory.build(:user, :password => '', :password_confirmation => '')

      test_size 4, @user , ["password", "password_confirmation"]
    end

    it "must have a unique username" do
      @user.save
      @second_user = Factory.build(:user)
      @second_user.username = @user.username
      @second_user.valid?.should == false
    end

    it "must have a unique email" do
      @user.save
      @second_user = Factory.build(:user)
      @second_user.email = @user.email
      @second_user.valid?.should == false
    end
  end

  describe "when updated" do

    before(:each) do
      @user = Factory.create(:user)
    end

    it "must be invalid without username" do
      @user.username = nil
      @user.valid?.should == false
    end

    it "must be invalid without email" do
      @user  = Factory.build(:user)
      @user.email = nil
      @user.valid?.should == false
    end

    it "must be invalid with invalid email" do
      @user.email = 'qqq@qqq'
      @user.valid?.should == false
    end

    it "must be invalid without password" do
      @user.password = nil
      @user.valid?.should == false
    end

    it "must be invalid with different password and password_confirmation" do
      @user.password = 'aaaaaaa'
      @user.valid?.should == false
    end

    it "must be invalid with different too short password" do
      test_size 4, @user , ["password", "password_confirmation"]
    end

    it "must have a unique username" do
      @second_user = Factory.create(:user)
      @second_user.username = @user.username
      @second_user.valid?.should == false
    end

    it "must have a unique email" do
      @second_user = Factory.create(:user)
      @second_user.email = @user.email
      @second_user.valid?.should == false
    end
  end

  #Test des champs d'une instance de model avec un certain nombre de fois
  def test_size times, object, fields
    value = ''
    fill_attributes object, fields, value
    times.times { |e|
      object.valid?.should be(false), "Echec avec '#{value}'"
      value+= 'a'
      fill_attributes object, fields, value
    }

    object.valid?.should be(true), "Echec avec '#{value}'"
  end

  it "must have a function to_s equal to username" do
    @user.to_s.should == @user.username
  end
  
  def protected_for_mass_assignment object, field, accessible = true
    object.attributes = {field => 'hax0rz'}
    if accessible
      object.send(field).should == 'hax0rz'
    else
      object.send(field).should_not == 'hax0rz'
    end
  end

  #Remplit les champs d'une instance de model avec une valeur
  def fill_attributes object, fields, value
    fields.each { |field|
      object.attributes = { field => value }
    }
  end


end
