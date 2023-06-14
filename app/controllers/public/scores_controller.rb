class Public::ScoresController < ApplicationController
  before_action :correct_user, only: [:edit]


  def search
    @scores = Score.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(12)
  end

  def search_detail
    @scores = Score.all
    @scores = @scores.where(name: params[:name]) if params[:name].present?
    @scores = @scores.where(member: params[:member]) if params[:member].present?
    @scores = @scores.where(artist: params[:artist]) if params[:artist].present?
    @scores = @scores.where(difficulty: params[:difficulty]) if params[:difficulty].present?
    @scores = @scores.order(created_at: :desc).page(params[:page]).per(12)
    #タグ検索
    @arrange_ids = params[:arrange_ids]&.select(&:present?)
    if @arrange_ids.present?
      @arrange_word = "タグ: "
      @arrange_ids.each do |id|
        @arrange_word = @arrange_word + ' ' + Arrange.find(id).body if id != ""
      end
      # @scores = @scores.joins(:arranges).where(arrange_tags: {arrange_id: @arrange_ids}).group("scores.id").having("count(*) = #{@arrange_ids.length}")
      @scores = @scores.joins(:arranges).where(arranges: { id: @arrange_ids}).page(params[:page]).per(12)
    end

    # 検索結果件数
    @scores_count = @scores.all.count

    render :search
  end

  def new
    @user = current_user
    @score = Score.new
  end

  def index
    @scores = Score.all.page(params[:page]).per(12)
    @all_scores_count = Score.all.count
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
    #arrange_list = params[:score][:body].to_s.split(nil)
    arrange_ids = params[:score][:arrange_ids]
    #binding.irb
    if @score.save
      #@score.save_arrange(arrange_list)
      @score.save_arrange(arrange_ids)
      flash[:notice] = "楽譜を投稿しました"
      redirect_to score_path(@score.id)
    else
      @user = current_user
      @score = Score.new
      flash[:notice] = "楽譜の投稿に失敗しました。曲名と歌手を必ず入力してください。"
      render :new
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
    @score = Score.find(params[:id])
    @sites = Site.all
    if @score.update(score_params)
      redirect_to score_path(@score)
      flash[:notice] = "楽譜が更新されました"
    else
      render :edit
    end
  end

  def destroy
    @score = Score.find(params[:id])
    @scores = current_user.scores
    if @score.destroy
      flash[:notice] = "楽譜が削除されました"
      redirect_to user_scores_path
    else
      render :edit
    end
  end

  def correct_user
    @score = Score.find(params[:id])
    @user = @score.user
    redirect_to score_path(@score) unless @user == current_user
  end


  private

  def score_params
    params.require(:score).permit(:user_id, :name, :artist, :member, :difficulty, :site_id, :image )
  end
end
