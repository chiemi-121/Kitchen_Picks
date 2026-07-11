require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "guest can open new post page from header link" do
    get root_url
    assert_select "a[href='#{new_post_path}']", text: "新規投稿"

    get new_post_url
    assert_response :success
    assert_select "h2", text: "レビュー投稿"
  end

  test "invalid post re-renders new with validation messages" do
    post login_url, params: { email: users(:one).email, password: "password" }
    assert_redirected_to mypage_path

    post posts_url, params: {
      post: {
        title: "",
        body: "",
        rating: "",
        category_id: categories(:one).id
      }
    }

    assert_response :unprocessable_entity
    assert_select "h2", text: "レビュー投稿"
    assert_select "div.alert.alert-danger", text: /入力内容を確認してください/
  end
end
