class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post, notice: "投稿しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  
    if params[:post][:remove_image_ids].present?
      params[:post][:remove_image_ids].each do |image_id|
        @post.images.find(image_id).purge
      end
    end

  # ★ 既存の更新処理（壊さない）
  if @post.update(post_params)
    redirect_to @post, notice: "投稿を更新しました！"
  else
    render :edit, status: :unprocessable_entity
  end
end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def ensure_correct_user
    unless @post.user_id == current_user.id
      redirect_to posts_path, alert: "権限がありません"
    end
  end

  def post_params
    params.require(:post).permit(
      :title,
      :body,
      :rating,
      :category_id,
      images: []   # ← 既存のままでOK
    )
  end
end