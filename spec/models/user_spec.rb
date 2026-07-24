require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it '全属性があるとき有効' do
      expect(build(:user)).to be_valid
    end

    it 'name が空のとき無効' do
      expect(build(:user, name: nil)).not_to be_valid
    end

    it 'email が空のとき無効' do
      expect(build(:user, email: nil)).not_to be_valid
    end

    it 'email が重複しているとき無効' do
      create(:user, email: 'dup@example.com')
      expect(build(:user, email: 'dup@example.com')).not_to be_valid
    end

    it 'email が異なれば有効' do
      create(:user, email: 'first@example.com')
      expect(build(:user, email: 'second@example.com')).to be_valid
    end
  end
end
