class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_comment, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to post_path(@comment.post_id), notice: "コメントを投稿しました！"
    else
      @post = Post.find(@comment.post_id)
      @comments = @post.comments.includes(:user).order(created_at: :desc)
      flash.now[:alert] = "コメントを入力してください。"
      render "posts/show", status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to post_path(@comment.post_id), notice: "コメントを削除しました。"
    else
      redirect_to post_path(@comment.post_id), alert: "自分のコメントのみ削除できます。"
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
