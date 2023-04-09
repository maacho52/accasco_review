class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :sex, :part, :birthday, :experience, :is_deleted)
  end
end
