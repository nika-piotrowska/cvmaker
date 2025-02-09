class EducationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_cv_and_section

  def create
    Education.create(section_id: @section.id, position: @section.educations.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    if @education.update(educations_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @education.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_education_up
    if @education.move_up
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_education_down
    if @education.move_down
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

  def educations_params
    return unless params.key?(:education)

    assure_end_date_format(params.require(:education).permit(
                             :level,
                             :city,
                             :university,
                             :faculty,
                             :specialisation,
                             :position,
                             :start_date,
                             :end_date
    ), @education.end_date)
  end
end
