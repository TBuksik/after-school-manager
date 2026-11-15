require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
  end

  test "index lists courses" do
    get courses_url

    assert_response :success
    assert_select "a", text: @course.name
  end

  test "show displays a course" do
    get course_url(@course)

    assert_response :success
  end

  test "new renders the form" do
    get new_course_url

    assert_response :success
  end

  test "create saves a valid course" do
    assert_difference("Course.count", 1) do
      post courses_url, params: { course: { name: "Piano", description: "Beginners welcome" } }
    end

    assert_redirected_to course_url(Course.last)
  end

  test "create with invalid data re-renders the form" do
    assert_no_difference("Course.count") do
      post courses_url, params: { course: { name: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "update changes the course" do
    patch course_url(@course), params: { course: { name: "Updated" } }

    assert_redirected_to course_url(@course)
    assert_equal "Updated", @course.reload.name
  end

  test "update with invalid data re-renders the form" do
    patch course_url(@course), params: { course: { name: "" } }

    assert_response :unprocessable_entity
  end

  test "destroy removes a course without groups" do
    course = Course.create!(name: "Temporary")

    assert_difference("Course.count", -1) do
      delete course_url(course)
    end

    assert_redirected_to courses_url
  end

  test "destroy keeps a course that has groups" do
    assert_no_difference("Course.count") do
      delete course_url(@course)
    end

    assert_redirected_to course_url(@course)
  end
end
