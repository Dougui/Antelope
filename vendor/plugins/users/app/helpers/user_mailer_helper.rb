module UserMailerHelper
  def link_for_activate(user)
    url = url_for(:controller => :user_activates, :action => :new, :id => user.perishable_token, :only_path => false)
    link_to(url, url)
  end
  
  def link_for_password_reset(user)
    url = url_for(:controller => :user_password_resets, :action => :edit, :id => user.perishable_token, :only_path => false)
    link_to(url, url)
  end
end