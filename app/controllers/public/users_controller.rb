class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    if @user.birthday != nil
      @user.birthday = (Date.today.strftime('%Y%m%d').to_i - @user.birthday.strftime('%Y%m%d').to_i) / 10000
    end  
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.update(user_params)
    flash[:notice] = "ユーザー情報が更新されました"
    redirect_to mypage_path
  end

  def scores_index
    @user = current_user
    @scores = @user.scores.page(params[:page]).per(12)
  end

  def reviews_index
    @user = current_user
    @reviews = @user.reviews.page(params[:page]).per(12)
  end

  def confirm
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
    params.require(:user).permit(:nickname, :email, :sex, :part, :birthday, :experience, :is_deleted, :profile_image)
  end
end
