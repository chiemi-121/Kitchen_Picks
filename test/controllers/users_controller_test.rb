require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count", 1) do
      post signup_url, params: {
        user: {
          name: "New User",
          email: "new_user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to mypage_path
  end
end
