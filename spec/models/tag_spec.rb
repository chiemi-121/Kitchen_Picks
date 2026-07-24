require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'validations' do
    it '全属性があるとき有効' do
      expect(build(:tag)).to be_valid
    end

    it 'name が空のとき無効' do
      expect(build(:tag, name: nil)).not_to be_valid
    end
  end
end
