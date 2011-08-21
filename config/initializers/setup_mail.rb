unless Rails.env.test?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'localhost',
    :user_name            => 'guirec.corbel@gmail.com',
    :password             => '3463FbKU',
    :authentication       => 'plain',
    :enable_starttls_auto => true  }

  Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
end