class Public::ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to score_path(@review.score)
    else
      @review = Review.find(params[:id])
      render "score/show"
    end
  end

  private
    def review_params
      params.require(:review).permit(:score_id, :title, :body, :star)
    end
end
