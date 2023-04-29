class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    @user.birthday = (Date.today.strftime('%Y%m%d').to_i - @user.birthday.strftime('%Y%m%d').to_i) / 10000
  end

  def edit
    @user = current_user
  end

  def score_index
    @user = current_user
    @scores = @user.scores.page(params[:page]).per(12)
  end

  def review_index
    @user = current_user
    @reviews = @user.reveiws.page(params[:page]).per(12)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :sex, :part, :birthday, :experience, :is_deleted)
  end
end
