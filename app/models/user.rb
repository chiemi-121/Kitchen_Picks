class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  has_secure_password  

  attribute :is_active, :boolean, default: true

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end