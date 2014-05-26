class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
       redirect_to '/sessions/new'
    else
       render 'new'
    end
  end

  def super_index
    @user = User.find(session[:user_id]).name
    @subject = '管理员用户列表'
    @users = User.where(admin: 'admin')
  end

  def super_new
    @name = User.find(session[:user_id]).name
    @subject = '管理员新建用户'
    @user = User.new
  end

  def super_create
    @user = User.new(user_params)
    @user.admin = 'admin'
    if @user.save
      redirect_to '/users/super_index'
    else
      render 'super_new'
    end
  end

  def edit
    @name = User.find(session[:user_id]).name
    @subject = '管理员编辑用户'
    @user = User.find(params[:format])
  end

  def update
    User.find(params[:id]).update_attributes(user_params)
    redirect_to root_path
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to '/users/super_index'
  end

  def quit
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
