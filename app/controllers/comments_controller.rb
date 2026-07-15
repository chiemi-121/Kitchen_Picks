class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_comment, only: [:destroy]
  before_action :set_post_for_create, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      @comments = @post.comments.includes(:user).order(created_at: :desc)

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_path(@comment.post_id), notice: "コメントを投稿しました！" }
      end
    else
      @comments = @post.comments.includes(:user).order(created_at: :desc)

      respond_to do |format|
        format.turbo_stream { render :create, status: :unprocessable_entity }
        format.html do
          flash.now[:alert] = "コメントを入力してください。"
          render "posts/show", status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    if @comment.user_id == current_user.id
      @post = @comment.post
      @comment.destroy
      @comments = @post.comments.includes(:user).order(created_at: :desc)
      @comment = Comment.new(post_id: @post.id)

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_path(@post), notice: "コメントを削除しました。" }
      end
    else
      redirect_to post_path(@comment.post_id), alert: "自分のコメントのみ削除できます。"
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post_for_create
    @post = Post.find(comment_params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
