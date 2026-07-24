require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "未ログインでも一覧を表示できる" do
      get posts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /posts/:id" do
    let(:post) { create(:post) }

    it "未ログインでも詳細を表示できる" do
      get post_path(post)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /posts/new" do
    it "未ログインはログインページへリダイレクト" do
      get new_post_path
      expect(response).to redirect_to(login_path)
    end

    it "ログイン済みは新規投稿フォームを表示できる" do
      user = create(:user)
      post login_path, params: { email: user.email, password: "password" }
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /posts" do
    it "未ログインはログインページへリダイレクト" do
      post posts_path, params: { post: { title: "テスト", body: "本文", rating: 3 } }
      expect(response).to redirect_to(login_path)
    end
  end
end