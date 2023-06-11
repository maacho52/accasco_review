class Admin::ScoresController < ApplicationController
  before_action :authenticate_admin!
  
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
      flash[:notice] = "楽譜情報を更新しました"
      redirect_to admin_score_path
    else
      render :edit
    end
  end

  def destroy
    @score = Score.find(params[:id])
    if @score.destroy
      flash[:notice] = "楽譜を削除しました"
      redirect_to admin_scores_path
    else
      render :edit
    end
  end

  private

  def score_params
    params.require(:score).permit(:name, :artist, :member, :difficulty, :user_id, :site_id, arrange_ids: [])
  end
end
