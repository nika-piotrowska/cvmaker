class CoursesController < ApplicationController
  load_and_authorize_resource

  def create
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    Course.create(section_id: @section.id, position: @section.courses.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    if @course.update(courses_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @cv = Cv.find(params[:cv_id])
    @course.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_course_up
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    up_course = @section.courses.find_by(position: @course.position - 1)
    if up_course.present?
      @course.update(position: @course.position - 1)
      up_course.update(position: up_course.position + 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_course_down
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    down_course = @section.courses.find_by(position: @course.position + 1)
    if down_course.present?
      @course.update(position: @course.position + 1)
      down_course.update(position: down_course.position - 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

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
