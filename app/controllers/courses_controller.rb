class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  def index
    @courses = Course.order(:name)
  end

  def show
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @course.destroy
      redirect_to courses_path, notice: t(".destroyed"), status: :see_other
    else
      redirect_to @course, alert: @course.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_course
    @course = Course.find(params.expect(:id))
  end

  def course_params
    params.expect(course: [ :name, :description ])
  end
end
