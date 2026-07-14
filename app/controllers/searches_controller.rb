class SearchesController < ApplicationController
  before_action :require_login

  def search
    @range = params[:range].presence_in(["User", "Post"]) || "Post"
    @search = params[:search].presence_in(["perfect", "forward", "backward", "partial"]) || "partial"
    @word = params[:word].to_s.strip

    @users = []
    @posts = []

    return if @word.blank?

    if @range == "User"
      @users = User.where(name: search_condition(@search, @word)).order(created_at: :desc)
    else
      @posts = Post.includes(:user, :category).where(title: search_condition(@search, @word)).order(created_at: :desc)
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
end