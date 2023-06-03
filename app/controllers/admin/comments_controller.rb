class Admin::CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id])
    @score = @comment.review.score
    @review = @comment.review
    @comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to admin_score_review_path(@score, @review)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body, :user_id, :reiview_id)
  end  
end
