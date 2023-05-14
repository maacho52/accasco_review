class Public::ScoresController < ApplicationController

  def search
    @scores = Score.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(12)

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
    @scores_count = @scores.page(params[:page]).per(12)
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
      @scores = Score.all.page(params[:page]).per(12)
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
    #arrange_list = params[:score][:name].split(',')
    # もしscoreの情報が更新されたら
    if  @score.update(score_params)
        #@score.save_arrange(arrange_list)
        redirect_to score_path(@score.id), notice: '更新完了しました:)'
    else
      render :edit
    end
  end

  private

  def score_params
    params.require(:score).permit(:user_id, :name, :artist, :member, :difficulty, :site_id, :image )
  end
end
