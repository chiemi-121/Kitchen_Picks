class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_post

  def create
    @post.favorites.find_or_create_by(user: current_user)

    respond_to do |format|
      format.turbo_stream { render_favorite_turbo_stream }
      format.html { redirect_back fallback_location: post_path(@post), notice: "いいねしました。" }
    end
  end

  def destroy
    @post.favorites.find_by(user: current_user)&.destroy

    respond_to do |format|
      format.turbo_stream { render_favorite_turbo_stream }
      format.html { redirect_back fallback_location: post_path(@post), notice: "いいねを取り消しました。" }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def render_favorite_turbo_stream
    render turbo_stream: [
      turbo_stream.replace(
        view_context.dom_id(@post, :favorite_count),
        partial: "posts/favorite_count",
        locals: { post: @post }
      ),
      turbo_stream.replace(
        view_context.dom_id(@post, :favorite_button_index),
        partial: "posts/favorite_button_index",
        locals: { post: @post }
      ),
      turbo_stream.replace(
        view_context.dom_id(@post, :favorite_button_show),
        partial: "posts/favorite_button_show",
        locals: { post: @post }
      )
    ]
  end
end
