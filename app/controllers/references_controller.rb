class ReferencesController < ApplicationController
  load_and_authorize_resource
  before_action :set_cv_and_section

  def create
    Reference.create(section_id: @section.id, position: @section.references.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    if @reference.update(references_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @reference.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_reference_up
    if @reference.move_up
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_reference_down
    if @reference.move_down
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

  def references_params
    return unless params.key?(:reference)

    params.require(:reference).permit(
      :company,
      :contact_person,
      :phone_number,
      :email,
      :description,
      :position
    )
  end
end
