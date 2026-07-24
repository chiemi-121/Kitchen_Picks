require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it '全属性があるとき有効' do
      expect(build(:post)).to be_valid
    end

    it 'title が空のとき無効' do
      expect(build(:post, title: nil)).not_to be_valid
    end

    it 'body が空のとき無効' do
      expect(build(:post, body: nil)).not_to be_valid
    end

    it 'rating が空のとき無効' do
      expect(build(:post, rating: nil)).not_to be_valid
    end

    it 'rating が 1 のとき有効（最小値）' do
      expect(build(:post, rating: 1)).to be_valid
    end

    it 'rating が 5 のとき有効（最大値）' do
      expect(build(:post, rating: 5)).to be_valid
    end

    it 'rating が 0 のとき無効（範囲外）' do
      expect(build(:post, rating: 0)).not_to be_valid
    end

    it 'rating が 6 のとき無効（範囲外）' do
      expect(build(:post, rating: 6)).not_to be_valid
    end
  end

  describe 'rating_immutable' do
    it '投稿後に rating を変更するとエラーになる' do
      post = create(:post)
      post.rating = 1
      expect(post).not_to be_valid
      expect(post.errors[:rating]).to include('は投稿後に変更できません')
    end
  end
end