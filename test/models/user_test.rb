require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Example User", email: :"user@example.com", password:"foobar", password_confirmation:"foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name=""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email=""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name="a" * 51
    assert_not @user.valid?
  end

  test "email should be too long" do
    @user.email="a" * 256
    assert_not @user.valid?
  end

  test "accept valid address" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org f.g@foo.jp alice+b@baz.cn]
    valid_addresses.each do |v|
      @user.email = v
      assert @user.valid?
    end
  end
  
  test "reject invalid address" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |iv|
      @user.email = iv
      assert_not @user.valid?
    end
  end
  
  test "email should be unique" do
    duplicate = @user.dup
    duplicate.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "pw should have min length" do
    @user.password = "aaaaa"
    @user.password_confirmation = "aaaaa"
    assert_not @user.valid?
  end

end
