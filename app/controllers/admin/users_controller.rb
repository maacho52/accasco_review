class Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.new
  end

  def show
    @user = current_user
    @user.age = (Date.today.strftime("%Y%m%d").to_i - @user.birthday.strftime("%Y%m%d").to_i) / 10000
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to users_mypage_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :nickname, :birthday, :part)
  end
end
