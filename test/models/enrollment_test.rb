require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
  setup do
    @student = students(:one)
    @group = groups(:two)
  end

  test "is active by default" do
    assert Enrollment.new(student: @student, group: @group).active?
  end

  test "student cannot have two active enrollments in the same group" do
    Enrollment.create!(student: @student, group: @group)
    duplicate = Enrollment.new(student: @student, group: @group)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:student_id], "has already been taken"
  end

  test "student can re-enroll after withdrawing" do
    Enrollment.create!(student: @student, group: @group, status: :withdrawn)

    assert Enrollment.new(student: @student, group: @group).valid?
  end

  test "database rejects a duplicate active enrollment even without validations" do
    Enrollment.create!(student: @student, group: @group)
    duplicate = Enrollment.new(student: @student, group: @group)

    assert_raises(ActiveRecord::RecordNotUnique) { duplicate.save!(validate: false) }
  end

  test "is invalid with an unknown status" do
    enrollment = Enrollment.new(student: @student, group: @group, status: "archived")

    assert_not enrollment.valid?
  end
end
