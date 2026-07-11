class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to post_path(@comment.post_id), notice: "コメントを投稿しました！"
    else
      redirect_to post_path(@comment.post_id), alert: "コメントを入力してください。"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
