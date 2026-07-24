require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:target_post) { create(:post) }

  describe "POST /posts/:post_id/favorite" do
    it "未ログインはログインページへリダイレクト" do
      post post_favorite_path(target_post)
      expect(response).to redirect_to(login_path)
    end

    it "ログイン済みはいいねできる" do
      user = create(:user)
      post login_path, params: { email: user.email, password: "password" }
      expect {
        post post_favorite_path(target_post)
      }.to change(Favorite, :count).by(1)
    end
  end

  describe "DELETE /posts/:post_id/favorite" do
    it "未ログインはログインページへリダイレクト" do
      delete post_favorite_path(target_post)
      expect(response).to redirect_to(login_path)
    end

    it "ログイン済みはいいねを取り消せる" do
      user = create(:user)
      post login_path, params: { email: user.email, password: "password" }
      create(:favorite, user: user, post: target_post)
      expect {
        delete post_favorite_path(target_post)
      }.to change(Favorite, :count).by(-1)
    end
  end
end
