class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:show, :destroy]

  def index
    @posts = Post.includes(:user, :comments, :category).order(created_at: :desc)
  end

  def show
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "レビューを削除しました。"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end