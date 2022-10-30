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
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:id])
    @section.destroy
    assure_position_consistancy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_section_up
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:id])
    up_section = @cv.sections.find_by(horizontal_position: @section.horizontal_position, vertical_position: @section.vertical_position - 1)
    if up_section.present?
      @section.update(vertical_position: @section.vertical_position - 1)
      up_section.update(vertical_position: up_section.vertical_position + 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_section_down
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:id])
    down_section = @cv.sections.find_by(horizontal_position: @section.horizontal_position, vertical_position: @section.vertical_position + 1)
    if down_section.present?
      @section.update(vertical_position: @section.vertical_position + 1)
      down_section.update(vertical_position: down_section.vertical_position - 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

  def assure_position_consistancy
    main_body_sections = @cv&.sections.where(horizontal_position: Section.horizontal_positions[:main_body])
    side_body_sections = @cv&.sections.where(horizontal_position: Section.horizontal_positions[:side_body])
    main_body_sections.order(:vertical_position).each.with_index(1) do |section, index|
      section.vertical_position = index
      section.save
    end
    side_body_sections.order(:vertical_position).each.with_index(1) do |section, index|
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
