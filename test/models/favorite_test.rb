require "test_helper"

class FavoriteTest < ActiveSupport::TestCase
  test "is valid with user and post" do
    favorite = Favorite.new(user: users(:one), post: posts(:two))

    assert favorite.valid?
  end

  test "is invalid without user" do
    favorite = Favorite.new(post: posts(:one))

    assert_not favorite.valid?
    assert_includes favorite.errors[:user], "must exist"
  end

  test "is invalid without post" do
    favorite = Favorite.new(user: users(:one))

    assert_not favorite.valid?
    assert_includes favorite.errors[:post], "must exist"
  end

  test "prevents duplicate favorite for same user and post" do
    duplicate = Favorite.new(user: users(:one), post: posts(:one))

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:user_id], "has already been taken"
  end
end
