require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "login with valid information and logout" do
    user = users(:user1)
    get new_user_session_path
    post user_session_path, params: { user: { email: user.email, password: "password" } }

    assert_redirected_to products_path
    follow_redirect!
    assert_select "a[href=?]", destroy_user_session_path
    delete destroy_user_session_path
    assert_redirected_to root_url
  end

  test "login with invalid information" do
    user = users(:user1)
    get new_user_session_path
    post user_session_path, params: { user: { email: user.email, password: "invalid" } }
    assert_response :unprocessable_content
  end
end
