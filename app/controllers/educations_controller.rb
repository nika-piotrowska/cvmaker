class EducationsController < ApplicationController
  load_and_authorize_resource

  def create
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    Education.create(section_id: @section.id, position: @section.educations.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    if @education.update(educations_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @cv = Cv.find(params[:cv_id])
    @education.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_education_up
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    up_education = @section.educations.find_by(position: @education.position - 1)
    if up_education.present?
      @education.update(position: @education.position - 1)
      up_education.update(position: up_education.position + 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_education_down
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    down_education = @section.educations.find_by(position: @education.position + 1)
    if down_education.present?
      @education.update(position: @education.position + 1)
      down_education.update(position: down_education.position - 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

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
