class ReferencesController < ApplicationController
  load_and_authorize_resource

  def create
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    Reference.create(section_id: @section.id, position: @section.references.size+1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    if @reference.update(references_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @cv = Cv.find(params[:cv_id])
    @reference.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_reference_up
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    up_reference = @section.references.find_by(position: @reference.position-1)
    if up_reference.present?
      @reference.update(position: @reference.position-1)
      up_reference.update(position: up_reference.position+1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_reference_down 
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    down_reference = @section.references.find_by(position: @reference.position+1)
    if down_reference.present?
      @reference.update(position: @reference.position+1)
      down_reference.update(position: down_reference.position-1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

  def references_params
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
