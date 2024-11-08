require "test_helper"

class AdminLoginTest < ActionDispatch::IntegrationTest
  test "login with valid information and logout" do
    admin = admins(:admin1)
    get new_admin_session_path
    post admin_session_path, params: { admin: { email: admin.email, password: "password" } }
    assert_redirected_to admins_products_path
    follow_redirect!
    assert_select "a[href=?]", destroy_admin_session_path
    delete destroy_admin_session_path
    assert_redirected_to new_admin_session_path
  end

  test "login with invalid information" do
    admin = admins(:admin1)
    get new_admin_session_path
    post admin_session_path, params: { admin: { email: admin.email, password: "invalid" } }
    assert_response :unprocessable_content
  end
end
