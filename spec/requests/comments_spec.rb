require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:target_post) { create(:post) }

  describe "POST /comments" do
    it "未ログインはログインページへリダイレクト" do
      post comments_path, params: { comment: { body: "テスト", post_id: target_post.id } }
      expect(response).to redirect_to(login_path)
    end

    it "ログイン済みはコメントを投稿できる" do
      user = create(:user)
      post login_path, params: { email: user.email, password: "password" }
      expect {
        post comments_path, params: { comment: { body: "テスト", post_id: target_post.id } }
      }.to change(Comment, :count).by(1)
    end
  end
end
