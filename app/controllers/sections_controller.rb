class SectionsController < ApplicationController
  load_and_authorize_resource

  def create
    @cv = Cv.find(params[:cv_id])
    vertical_position = @cv.sections.where(horizontal_position: Section.horizontal_positions[:main_body]).size + 1
    section = Section.new(sections_params)
    section.vertical_position = vertical_position
    section.cv_id = params[:cv_id]
    if section.save
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    else
      respond_to do |format|
        format.js { render 'sections/new_section_form.js.erb', layout: false }
      end
    end
  end

  private

  def sections_params
    params.require(:cv).permit(
      :name,
      :certificates_section,
      :courses_section,
      :educations_section,
      :employments_section,
      :languages_section,
      :references_section,
      :skills_section,
      :interest_section,
      :privacy_policy_sections,
      :description_section,
      :custom_section,
      :vertical_position
    )
  end
end
