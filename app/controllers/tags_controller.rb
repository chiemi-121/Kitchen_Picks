class TagsController < ApplicationController
  def index
    @search = params[:search].presence_in(["perfect", "forward", "backward", "partial"]) || "partial"
    @word = params[:word].to_s.strip

    @tags = Tag.order(:name)
    return if @word.blank?

    keyword = search_condition(@search, @word)
    @tags = Tag
      .left_outer_joins(:posts)
      .where("tags.name LIKE :word OR posts.title LIKE :word OR posts.body LIKE :word", word: keyword)
      .distinct
      .order(:name)
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.order(created_at: :desc)
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