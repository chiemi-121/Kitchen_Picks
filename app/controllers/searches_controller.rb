class SearchesController < ApplicationController
  before_action :require_login

  def search
    @range = params[:range].presence_in(["User", "Post", "Tag"]) || "Post"
    @search = params[:search].presence_in(["perfect", "forward", "backward", "partial"]) || "partial"
    @word = params[:word].to_s.strip

    @users = []
    @posts = []

    if @range == "Tag"
      redirect_to tags_path(word: @word, search: @search, range: "Tag") and return
    end

    return if @word.blank?

    if @range == "User"
      @users = User.where(search_scope_for_users, search_params).order(created_at: :desc)
    else
      @posts = Post.includes(:user, :category).where(search_scope_for_posts, search_params).order(created_at: :desc)
    end
  end

  private

  def search_condition(search_type, word)
    case search_type
    when "perfect"
      word
    when "forward"
      "#{word}%"
    when "backward"
      "%#{word}"
    else
      "%#{word}%"
    end
  end

  def search_scope_for_users
    "name LIKE :word OR email LIKE :word"
  end

  def search_scope_for_posts
    "title LIKE :word OR body LIKE :word"
  end

  def search_params
    { word: search_condition(@search, @word) }
  end
end