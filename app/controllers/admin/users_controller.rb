class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    if @user.birthday != nil
      @user.birthday = (Date.today.strftime('%Y%m%d').to_i - @user.birthday.strftime('%Y%m%d').to_i) / 10000
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "ユーザー情報を更新しました"
    redirect_to admin_user_path
  end


  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :nickname, :birthday, :part)
  end
end
