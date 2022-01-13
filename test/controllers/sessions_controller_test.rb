require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:cam)
  end

  test "login with incorrect params" do
    post login_path, params: { session: { username: "foo", password: "foobar", password_confirmation: "foobar" } }, as: :json

    assert session[:user_id].nil?
  end

  test "login with correct params" do
    post login_path, params: { session: { username: @user.username, password: "foobar", password_confirmation: "foobar" } }, as: :json

    assert session[:user_id] == @user.id
  end
end
