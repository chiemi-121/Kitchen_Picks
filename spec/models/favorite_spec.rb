require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'validations' do
    it '全属性があるとき有効' do
      expect(build(:favorite)).to be_valid
    end

    it '同じユーザーが同じ投稿に2回いいねできない' do
      user = create(:user)
      post = create(:post)
      create(:favorite, user: user, post: post)
      expect(build(:favorite, user: user, post: post)).not_to be_valid
    end

    it '異なるユーザーなら同じ投稿にいいね可能' do
      post = create(:post)
      create(:favorite, user: create(:user), post: post)
      expect(build(:favorite, user: create(:user), post: post)).to be_valid
    end
  end
end
