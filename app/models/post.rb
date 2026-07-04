class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :comments, dependent: :destroy

  # タグ機能（多対多）
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # 画像（複数枚）
  has_many_attached :images

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true
end