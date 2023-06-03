class Admin::ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @score = Score.find_by(id: params[:score_id])
    @review = Review.find(params[:id])
    @comments = @review.comments
  end

  def edit
    @user = current_user
    @reveiw = @user.review
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "レビューを削除しました"
    redirect_to admin_score_reviews_path
  end

  private

  def reveiw_params
    #params.require(:review).permit(:user_id, :score_id, :title, :body, :star)
    params.require(:review).permit(:title, :body, :star)
  end
end
