class CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :set_cv_and_section

  def create
    Course.create(section_id: @section.id, position: @section.courses.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    if @course.update(courses_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_course_up
    if @course.move_up
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_course_down
    if @course.move_down
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

  def set_cv_and_section
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
  end

  def courses_params
    return unless params.key?(:course)

    assure_end_date_format(params.require(:course).permit(
                             :name,
                             :institution,
                             :start_date,
                             :end_date,
                             :description,
                             :position
    ), @course.end_date)
  end
end
