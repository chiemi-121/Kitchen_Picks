require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should redirect new to login" do
    get signup_url
    assert_redirected_to login_path
  end

  test "should not create user" do
    assert_no_difference("User.count") do
      post signup_url, params: {
        user: {
          name: "New User",
          email: "new_user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to login_path
  end
end
