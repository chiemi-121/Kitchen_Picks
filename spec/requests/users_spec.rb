require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /mypage" do
    it "未ログインはログインページへリダイレクト" do
      get mypage_path
      expect(response).to redirect_to(login_path)
    end

    it "ログイン済みはマイページを表示できる" do
      user = create(:user)
      post login_path, params: { email: user.email, password: "password" }
      get mypage_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /signup" do
    it "未ログインでも新規登録フォームを表示できる" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /signup" do
    it "正しい情報で登録するとマイページへリダイレクト" do
      post signup_path, params: {
        user: { name: "新規ユーザー", email: "new@example.com",
                password: "password", password_confirmation: "password" }
      }
      expect(response).to redirect_to(mypage_path)
    end

    it "メールアドレスが重複していると登録失敗" do
      create(:user, email: "dup@example.com")
      post signup_path, params: {
        user: { name: "ユーザー", email: "dup@example.com",
                password: "password", password_confirmation: "password" }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
