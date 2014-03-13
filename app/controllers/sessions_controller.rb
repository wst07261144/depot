class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      sign_in (user)
      redirect_to '#'
    else
      flash.now[:error] = '帐号或密码不正确'
      render 'new'
    end
  end




end
