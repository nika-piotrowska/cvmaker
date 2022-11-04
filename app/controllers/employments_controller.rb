class EmploymentsController < ApplicationController
  load_and_authorize_resource

  def create
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    Employment.create(section_id: @section.id, position: @section.employments.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    if @employment.update(employments_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @cv = Cv.find(params[:cv_id])
    @employment.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_employment_up
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    up_employment = @section.employments.find_by(position: @employment.position - 1)
    if up_employment.present?
      @employment.update(position: @employment.position - 1)
      up_employment.update(position: up_employment.position + 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_employment_down
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    down_employment = @section.employments.find_by(position: @employment.position + 1)
    if down_employment.present?
      @employment.update(position: @employment.position + 1)
      down_employment.update(position: down_employment.position - 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

  def employments_params
    return unless params.key?(:employment)

    assure_end_date_format(params.require(:employment).permit(
      :name,
      :city,
      :employer,
      :start_date,
      :end_date,
      :description,
      :position
    ), @employment.end_date)
  end
end
