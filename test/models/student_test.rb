require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "is valid with first and last name" do
    assert Student.new(first_name: "Anna", last_name: "Nowak").valid?
  end

  test "is invalid without a first or last name" do
    student = Student.new

    assert_not student.valid?
    assert_includes student.errors[:first_name], "can't be blank"
    assert_includes student.errors[:last_name], "can't be blank"
  end

  test "full_name joins first and last name" do
    assert_equal "Anna Nowak", Student.new(first_name: "Anna", last_name: "Nowak").full_name
  end
end
