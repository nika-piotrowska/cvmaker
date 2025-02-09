class CertificatesController < ApplicationController
  load_and_authorize_resource
  before_action :set_cv_and_section

  def create
    Certificate.create(section_id: @section.id, position: @section.certificates.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    if @certificate.update!(certificates_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @certificate.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_certificate_up
    if @certificate.move_up
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_certificate_down
    if @certificate.move_down
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
