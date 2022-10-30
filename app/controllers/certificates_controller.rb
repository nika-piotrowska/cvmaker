class CertificatesController < ApplicationController
  load_and_authorize_resource

  def create
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    Certificate.create(section_id: @section.id, position: @section.certificates.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    if @certificate.update(certificates_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @cv = Cv.find(params[:cv_id])
    @certificate.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_certificate_up
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    up_certificate = @section.certificates.find_by(position: @certificate.position - 1)
    if up_certificate.present?
      @certificate.update(position: @certificate.position - 1)
      up_certificate.update(position: up_certificate.position + 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_certificate_down
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    down_certificate = @section.certificates.find_by(position: @certificate.position + 1)
    if down_certificate.present?
      @certificate.update(position: @certificate.position + 1)
      down_certificate.update(position: down_certificate.position - 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

  def certificates_params
    return unless params.key?(:certificate)
    params.require(:certificate).permit(
      :name,
      :date,
      :description,
      :position
    )
  end
end
