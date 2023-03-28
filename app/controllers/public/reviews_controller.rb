class Public::ReviewsController < ApplicationController
  
  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to score_path(@review.score)
  end

  private
    def review_params
      params.require(:review).permit(:score_id, :title, :body, :star)
    end
end
