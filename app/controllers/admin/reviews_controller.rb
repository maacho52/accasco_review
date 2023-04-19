class Admin::ReviewsController < ApplicationController
  def index
    @score = Score.find(params[:score_id])
    @reviews = Review.all
  end

  def show
    @user = User.find(params[:user_id])
    @score = Score.find(prams[:score_id])
    @reveiw = Review.find(params[:id])
    @comments = @review.comments
  end

  def edit
    @user = current_user
    @reveiw = @user.review
  end

  private

  def reveiw_params
    params.require(:review).permit(:user_id, :score_id, :title, :body, :star)
  end
end
