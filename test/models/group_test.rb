require "test_helper"

class GroupTest < ActiveSupport::TestCase
  test "is valid with a course, a name and a positive capacity" do
    assert Group.new(course: courses(:one), name: "Beginners", capacity: 8).valid?
  end

  test "is invalid without a name" do
    group = Group.new(course: courses(:one), capacity: 8)

    assert_not group.valid?
    assert_includes group.errors[:name], "can't be blank"
  end

  test "is invalid with zero capacity" do
    group = Group.new(course: courses(:one), name: "Beginners", capacity: 0)

    assert_not group.valid?
    assert_includes group.errors[:capacity], "must be greater than 0"
  end

  test "is invalid without a course" do
    assert_not Group.new(name: "Beginners", capacity: 8).valid?
  end
end
