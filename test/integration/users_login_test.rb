require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:cam)
  end

  test "unsuccessful login" do
    post login_url, params: { session: { username: "incorrect", password: "foobar", password_confirmation: "foobar" } }, as: :json

    assert response.body =~ /Invalid credentials/
    assert_not is_logged_in?
  end

  test "successful login" do
    post login_url, params: { session: { username: @user.username, password: "foobar", password_confirmation: "foobar" } }, as: :json

    assert is_logged_in?
    assert response.body =~ /cameronjtong/
  end
end
