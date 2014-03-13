module ApplicationHelper

  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
   session[:user_id].nil? ? nil :  User.find(session[:user_id])
  end

  def current_user_id
    current_user.id
  end

  def signed_in?
    !current_user.nil?
  end


end
