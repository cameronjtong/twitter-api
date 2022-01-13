require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "camjtong", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username must be present" do
    @user.username = " "

    assert_not @user.valid?
  end

  test "username must not be too long" do
    @user.username = "a" * 51

    assert_not @user.valid?
  end

  test "usernames are unique independant of case" do
    duplicate_user = @user.dup
    duplicate_user.username = @user.username.upcase

    @user.save

    assert_not duplicate_user.valid?
  end

  test "password cannot be blank" do
    @user.password = @user.password_confirmation = "   "

    assert_not @user.valid?
  end

  test "passwords must be at least six characters" do
    @user.password = @user.password_confirmation = "a" * 5

    assert_not @user.valid?
  end
end
