require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to login when creating comment without login" do
    assert_no_difference("Comment.count") do
      post comments_url, params: { comment: { post_id: posts(:one).id, body: "Nice" } }
    end

    assert_redirected_to login_path
  end

  test "should create comment when logged in" do
    post login_url, params: { email: users(:one).email, password: "password" }

    assert_difference("Comment.count", 1) do
      post comments_url, params: { comment: { post_id: posts(:one).id, body: "Nice" } }
    end

    assert_redirected_to post_path(posts(:one))
  end
end
