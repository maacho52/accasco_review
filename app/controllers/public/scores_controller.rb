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
  
  def save_arrange(sent_arrranges)
  # アレンジが存在していれば、アレンジの名前を配列として全て取得
    current_arranges = self.arranges.pluck(:name) unless self.arranges.nil?
    # 現在取得したアレンジから送られてきたアレンジを除いてoldarrangeとする
    old_arranges = current_arranges - sent_arranges
    # 送信されてきたアレンジから現在存在するアレンジを除いたアレンジをnewとする
    new_arranges = sent_arranges - current_arranges

     # 古いアレンジを消す
    old_arranges.each do |old|
      self.arranges.delete　Arrange.find_by(name: old)
    end

    # 新しいアレンジを保存
    new_arranges.each do |new|
      new_arrange_tag = Arrange.find_or_create_by(name: new)
      self.arranges << new_arrange_tag
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
    @arranges = @score.arranges
  end

  private

  def score_params
    params.require(:score).permit(:name, :artist, :member, :difficulty)
  end
end
