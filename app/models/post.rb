class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  # タグ機能（多対多）
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # 画像（複数枚）
  has_many_attached :images

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true

  def favorited_by?(user)
    return false unless user

    if favorites.loaded?
      favorites.any? { |favorite| favorite.user_id == user.id }
    else
      favorites.exists?(user_id: user.id)
    end
  end
end