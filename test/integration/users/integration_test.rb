require "test_helper"

class Users::IntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:user1)
    sign_in @user
  end
end
