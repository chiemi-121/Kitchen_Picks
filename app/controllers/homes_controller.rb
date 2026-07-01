class HomesController < ApplicationController
  def top
    # トップページ表示用データ
    #@latest_reviews = Review.order(created_at: :desc).limit(4)
    #@popular_items = Item.order(favorites_count: :desc).limit(4)
  end

  def about
  end
end