require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "is valid with a name" do
    assert Course.new(name: "Guitar").valid?
  end

  test "is invalid without a name" do
    course = Course.new

    assert_not course.valid?
    assert_includes course.errors[:name], "can't be blank"
  end

  test "cannot be destroyed while it has groups" do
    course = courses(:one)

    assert_not course.destroy
    assert_not_empty course.errors[:base]
  end
end
