class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @review = Review.find(params[:review_id])
    @score = @review.score
    @comment = current_user.comments.new
  end

  def create
    @review = Review.find(params[:review_id])
    @comment = current_user.comments.new(comment_params)
    @comment.review.user != current_user
    if @comment.save
      redirect_to score_review_path(@review.score, @review)
    else
      render :new
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "コメントを削除しました"
    end
    redirect_to score_review_path(@comment.review.score, @comment.review)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :review_id).merge(user_id: current_user.id)
  end
end
