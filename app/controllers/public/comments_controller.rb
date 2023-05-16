class Public::CommentsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    else
      redirect_back(fallback_location: root_path)  #同上
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body, :review_id).merge(user_id: current_user.id)
  end
end
