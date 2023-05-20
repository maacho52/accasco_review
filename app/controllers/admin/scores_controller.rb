class Admin::ScoresController < ApplicationController
  def index
    @scores = Score.all.page(params[:page]).per(8)
  end

  def show
    @score = Score.find(params[:id])
    @site = @score.site
    #@score_arranges = @score.arranges
  end

  def edit
    @score = Score.find(params[:id])
    @sites = Site.all
  end
  
  def update
    @score = Score.find(params[:id])
    @sites = Site.all
    if @score.update(score_params)
      redirect_to admin_score_path
    else
      render :edit
    end  
  end

  private

  def score_params
    params.require(:score).permit(:name, :artist, :member, :difficulty, :user_id, arrange_ids: [])
  end
end
