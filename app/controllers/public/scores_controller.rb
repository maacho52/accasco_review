class Public::ScoresController < ApplicationController
  
  def search
    @scores = Score.search(params[:keyword]).order(created_at: :desc)
  end
  
  def new
    @user = current_user
    @score = Score.new
  end

  def index
    @scores = all_scores.page(params[:page]).per(12)
    @all_scores_count = all_scores.count
    #@user = current_user
    #@user.scores = current_user.scores.all
    @arrange_list = Arrange.all
    
    if params[:search].present?
      scores = Score.scores_serach(params[:search])
    elsif params[:arrange_id].present?
      @arrange = arrange.find(params[:arrange_id])
      scores = @arrange.scores.order(created_at: :desc)
    else
      scores = Score.all.order(created_at: :desc)
    end
    

  end

  def create
    @score = Score.new(score_params)
    @score.user_id = current_user.id
     # 受け取った値を,で区切って配列にする
    arrange_list = params[:score][:name].split(',')
    if @score.save
      @post.save_tag(arrange_list)
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
    @reviews = @score.reviews
    #レビュー全件表示
    @site = @score.site
    @score_arranges = @score.arranges
  end
  
  def update
    # scoreのid持ってくる
    @socre = Score.find(params[:id])
    # 入力されたタグを受け取る
    arrange_list = params[:score][:name].split(',')
    # もしscoreの情報が更新されたら
    if  @score.update(score_params)
        @score.save_arrange(arrange_list)
        redirect_to score_path(@score.id), notice: '更新完了しました:)'
    else
      render :edit
    end
  end

  private

  def score_params
    params.require(:score).permit(:name, :artist, :member, :difficulty, :sites_id, :arranges_id)
  end
end
