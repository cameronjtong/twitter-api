require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup" do
    new_user_params = { user: { username: "", password: "foobar", password_confirmation: "foobar" } }

    assert_no_difference "User.count" do
      post users_path, params: new_user_params
    end
    assert response.body =~ /errors/
  end

  test "valid signup" do
    new_user_params = { user: { username: "validusername", password: "foobar", password_confirmation: "foobar" } }
    assert_difference "User.count" do
      post users_path, params: new_user_params
    end
    assert_response :created
    assert is_logged_in?
  end
end
