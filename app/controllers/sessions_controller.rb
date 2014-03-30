class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      sign_in (user)
      if user.admin == 'super'
        redirect_to :action => 'super_index', :controller => 'users'
      else
        redirect_to :action => 'index',:controller => 'products'
      end
    else
      flash.now[:error] = '帐号或密码不正确'
      render 'new'
    end
  end

  private

  def sign_in(user)
    session[:user_id] = user.id
  end


end
