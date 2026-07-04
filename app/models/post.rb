class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many_attached :images

  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true
end