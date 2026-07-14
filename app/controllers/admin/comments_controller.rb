class Admin::CommentsController < Admin::BaseController
  before_action :set_comment, only: [:destroy]

  def destroy
    post = @comment.post
    @comment.destroy
    redirect_to admin_post_path(post), notice: "コメントを削除しました。"
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
end