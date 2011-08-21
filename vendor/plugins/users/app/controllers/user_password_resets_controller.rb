class UserPasswordResetsController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user
      @user.reset_perishable_token!
      UserMailer.reset_password(@user).deliver
      redirect_to(login_path, :notice => t("successfully_created", :scope => 'user_password_resets.controller'))
    else
      @user = User.new(:email => params[:user][:email])
      @user.valid?
      render :new
    end
  end

  def edit

  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      redirect_to(root_path, :notice => t("successfully_updated", :scope => 'user_password_reset.controller'))
    else
      render :action => :edit
    end
  end
end
