require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest


  test "requires authentication" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path

    user = User.create(email: "test@example.com", password: "password")
    post user_session_path, params: { user: { email: user.email, password: "password" } }
    follow_redirect!
    assert_response :success
  end

  test "cannot sign in fail" do
    post user_session_path, params: { user: { email: "invalid@example.com", password: "wrongpassword" } }
    assert_response :unprocessable_entity
    assert_equal "Invalid Email or password.", flash[:alert]
  end
end