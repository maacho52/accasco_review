class Public::ScoresController < ApplicationController

  def new
    @user = current_user
    @score = Score.new
  end

  def index
    @scores = all_scores.page(params[:page]).per(12)
    @all_scores_count = all_scores.count
    #@user = current_user
    #@user.scores = current_user.scores.all
  end

  def create
    @score = Score.new(score_params)
    @score.user_id = current_user.id
    if @score.save
      flash[:notice] = "楽譜を投稿しました"
      redirect_to score_path(@score.id)
    else
      @scores = Score.all
      render :index
    end

  end

  def edit
    @score = Score.find(params[:id])
    @user = current_user
  end

  def show
    @score = Score.find(params[:id])
    @review = Review.new
  end

  private

  def score_params
    params.require(:score).permit(:name, :artist, :member, :difficulty)
  end
end
