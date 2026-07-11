class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show, :new]
  before_action :forbid_guest, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.except(:images))
    @post.user_id = current_user.id

    if @post.save
      attach_images(@post, uploaded_images)
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

    if @post.update(post_params.except(:images))
      attach_images(@post, uploaded_images)
      redirect_to @post, notice: "投稿を更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to mypage_path, notice: "投稿を削除しました。"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :title,
      :body,
      :rating,
      :category_id,
      images: [],
      tag_ids: []
    )
  end

  def ensure_post_owner
    return if @post.user_id == current_user.id

    redirect_to posts_path, alert: "他ユーザーの投稿は編集できません"
  end

  def attach_images(post, images)
    return if images.blank?

    post.images.attach(images)
  end

  def uploaded_images
    Array(params.dig(:post, :images)).reject(&:blank?)
  end
end