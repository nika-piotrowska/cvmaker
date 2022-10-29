class CertificatesController < ApplicationController
  load_and_authorize_resource

  def create
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    Certificate.create(section_id: @section.id, position: @section.certificates.size+1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    
  end

  private

  def certificates_params
    params.require.permit(
      :name,
      :date,
      :description,
      :position
    )
  end
end
