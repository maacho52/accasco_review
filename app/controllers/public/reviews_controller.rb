class Public::ReviewsController < ApplicationController

  def show
    @score = Score.find(params[:score_id])
    #@review.user_id = current_user.id
    @user = current_user
    @review = @user.reviews.find_by(id: params[:id])
    @comments = @review.comments
    @comment = current_user.comments.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to score_path(@review.score)
    else
      @score = Score.find(params[:score_id])
      render "public/scores/show"
    end
  end

  def edit
    @score = Score.find(params[:score_id])
    @review = Review.find(params[:id])
    @user = current_user

  end

  def update
    @user = current_user
    @review = @user.reviews.find(params[:id])
    #binding.pry
    if @review.update!(review_params)
      #flash[:notice] = "review was successfully updated."
      redirect_to score_review_path(@review.score, @review)
    else
      render :edit
    end
  end

  def index
    @score = Score.find(params[:score_id])
    @reviews = current_user.reviews.find_by(score_id: @score.id)
  end

  private

  def review_params
    #params.require(:review).permit(:score_id, :user_id, :title, :body, :star)
    params.require(:review).permit(:title, :body, :star).merge(user_id: current_user.id)
    #params.require(:review).permit(:score_id, :title, :body, :all_rating, :rating1, :rating2, :rating3, :rating4)
  end

end
