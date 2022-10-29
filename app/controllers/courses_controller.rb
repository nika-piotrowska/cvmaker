class CoursesController < ApplicationController
  load_and_authorize_resource

  def create
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    Course.create(section_id: @section.id, position: @section.courses.size+1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    byebug
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    if @course.update(courses_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

  def courses_params
    params.require(:course).permit(
      :name,
      :institution,
      :start_date,
      :end_date,
      :description,
      :position
    )
  end
end
