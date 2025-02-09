class EmploymentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_cv_and_section

  def create
    Employment.create(section_id: @section.id, position: @section.employments.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    if @employment.update(employments_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @employment.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_employment_up
    if @employment.move_up
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_employment_down
    if @employment.move_down
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
