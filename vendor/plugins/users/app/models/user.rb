#encoding=utf-8
class User < ActiveRecord::Base

  acts_as_authentic do |config|
    config.ignore_blank_passwords = false
    config.merge_validates_format_of_email_field_options :message => "ne semble pas être une adresse de courriel valide."
  end

  attr_accessible :username, :email, :password, :password_confirmation

  validate :password, :presence => true

  def active?
    active
  end

  def to_s
    self.username
  end
end
