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
    if @section.horizontal_position != sections_params(:section)[:horizontal_position]
      params[:section][:vertical_position] = @cv.sections.where(horizontal_position: sections_params(:section)[:horizontal_position]).size + 1
    end
    if @section.update(sections_params(:section))
      assure_position_consistancy
      byebug
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

  def assure_position_consistancy
    mainBodySections = @cv.sections.where(horizontal_position: Section.horizontal_positions[:main_body])
    sideBodySections = @cv.sections.where(horizontal_position: Section.horizontal_positions[:side_body])
    mainBodySections.each.with_index(1) do | section, index |
      section.vertical_position = index
      section.save
    end
    sideBodySections.each.with_index(1) do | section, index |
      section.vertical_position = index
      section.save
    end
  end

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
