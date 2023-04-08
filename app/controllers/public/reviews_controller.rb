class Public::ReviewsController < ApplicationController

  def show
    @score = Score.find(params[:score_id])
    @review = @score.review
    @review.user_id = current_user.id
    @user = current_user
    @comments = @review.comments.all
    @comment = current_user.comments.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to score_path(@review.score)
    else
      @review = Review.find(params[:id])
      render "score/show"
    end
  end

  def edit
    @review = Review.find(params[:id])

  end

  def index
    @score = Score.find(params[:score_id])
    @reviews = current_user.reviews
  end

  private

  def review_params
    params.require(:review).permit(:score_id, :title, :body, :star)
  end

end
