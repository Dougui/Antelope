class UserMailer < ActionMailer::Base
  default :from => "guirec.corbel@gmail.com"

  def activation(user)
    @user = user
    mail(:to => user.email, :subject => t(".title_activation", :scope => 'users.mailer'))
  end

  def reset_password(user)
    @user = user
    mail(:to => user.email, :subject => t(".title_reset_password", :scope => 'users.mailer'))
  end
end
