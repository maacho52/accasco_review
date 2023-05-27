class Public::ReviewsController < ApplicationController

  def show
    @score = Score.find(params[:score_id])
    #@review.user_id = current_user.id
    @user = current_user
    @review = @user.reviews.find_by(id: params[:id])
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.score.user_id != current_user.id
      @review.save
      redirect_to score_path(@review.score)
    else
      @score = Score.find(params[:score_id])
      flash[:notice] = "自身が投稿した楽譜にレビューはできません。"
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

  def destroy
    @user = current_user
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_to score_path(@review.score)
    else
      render :edit
    end  
  end
  
  def index
    @score = Score.find(params[:score_id])
    @reviews = @score.reviews
  end

  private

  def review_params
    #params.require(:review).permit(:score_id, :user_id, :title, :body, :star)
    params.require(:review).permit(:title, :body, :star, :score_id).merge(user_id: current_user.id)
    #params.require(:review).permit(:score_id, :title, :body, :all_rating, :rating1, :rating2, :rating3, :rating4)
  end

end
