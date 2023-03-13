require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest


  def teardown
    User.destroy_all
  end

  test "can create user" do
    assert_difference "User.count", 1 do
      post user_registration_path, params: {
        user: {
          full_name: "Pepe",
          email: "prueba@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_equal "You have signed up successfully.", flash[:notice]
  end
end