class Admin::UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = current_user
    @user.birthday = (Date.today.strftime("%Y%m%d").to_i - @user.birthday.strftime("%Y%m%d").to_i) / 10000
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to admin_user_path
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :nickname, :birthday, :part)
  end
end
