class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @user.birthday = (Date.today.strftime('%Y%m%d').to_i - @user.birthday.strftime('%Y%m%d').to_i) / 10000
  end
  
  def edit
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :sex, :part, :birthday, :experience, :is_deleted)
  end
end
