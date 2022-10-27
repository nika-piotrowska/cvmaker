class SectionsController < ApplicationController
  load_and_authorize_resource

  def create
    @cv = Cv.find(params[:cv_id])
    vertical_position = @cv.sections.where(horizontal_position: Section.horizontal_positions[:main_body]).size + 1
    section = Section.new(sections_params(:cv))
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

  def update
    @section = Section.find(params[:id])
    @cv = Cv.find(params[:cv_id])
    if @section.update(sections_params(:section))
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

  def sections_params(required_symbol)
    params.require(required_symbol).permit(
      :name,
      :vertical_position,
      :custom_name,
      :content,
      :horizontal_position
    )
  end
end
