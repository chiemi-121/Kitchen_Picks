require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should login with valid credentials" do
    post login_url, params: { email: users(:one).email, password: "password" }
    assert_redirected_to mypage_path
  end

  test "should logout" do
    post login_url, params: { email: users(:one).email, password: "password" }
    delete logout_url
    assert_redirected_to root_path
  end
end
