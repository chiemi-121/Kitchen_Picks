require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /login" do
    let(:user) { create(:user) }

    it "正しい認証情報でログインするとマイページへリダイレクト" do
      post login_path, params: { email: user.email, password: "password" }
      expect(response).to redirect_to(mypage_path)
    end

    it "パスワードが誤っているとログイン失敗" do
      post login_path, params: { email: user.email, password: "wrong" }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "存在しないメールアドレスはログイン失敗" do
      post login_path, params: { email: "none@example.com", password: "password" }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "停止中アカウントはログイン失敗" do
      user.update!(is_active: false)
      post login_path, params: { email: user.email, password: "password" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /logout" do
    it "ログアウトするとaboutページへリダイレクト" do
      user = create(:user)
      post login_path, params: { email: user.email, password: "password" }
      delete logout_path
      expect(response).to redirect_to(about_path)
    end
  end
end
