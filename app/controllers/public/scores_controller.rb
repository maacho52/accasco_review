class Public::ScoresController < ApplicationController
  
  def new
    @user = current_user
    @score = Score.new
  end
  
  def index
    @scores = all_scores.page(params[:page]).per(12)
    #@user = current_user
    #@user.scores = current_user.scores.all
  end
  
  def create
  end
  
  def edit
  end
  
  def show
  end
  
  private
  
  def score_params
    params.require(:score).permit(:name, :artist, :member, :difficulty)
  end
end
