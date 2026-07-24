require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it '全属性があるとき有効' do
      expect(build(:comment)).to be_valid
    end

    it 'body が空のとき無効' do
      expect(build(:comment, body: nil)).not_to be_valid
    end
  end
end
