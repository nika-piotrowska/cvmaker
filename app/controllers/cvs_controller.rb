class CvsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def create
    cv = Cv.new(email: current_user.email, name: "CV#{current_user.cvs.size + 1}", user_id: current_user.id)
    if cv.save
      redirect_to edit_user_cv_path(user_id: current_user.id, id: cv.id)
    else
      redirect_to dashboard_users_path, notice: t('.notice')
    end
  end

  def edit
  end
  
  def update
    if @cv.update(cv_params)
      @section = Section.new
      display_sections
    else
      display_personal_information
    end
  end

  def display_personal_information
    respond_to do |format|
      format.js { render 'cvs/personal_information.js.erb', layout: false }
    end
  end

  def display_sections
    respond_to do |format|
      format.js { render 'cvs/sections.js.erb', layout: false }
    end
  end

  def display_styles
    respond_to do |format|
      format.js { render 'cvs/styles.js.erb', layout: false }
    end
  end

  def download_pdf
    @static_pdf = render_to_body disable_javascript: false, javascript_delay: 3000, pdf: 'pdf', template: "cvs/style1.html.erb", encoding: 'UTF-8'
    @static_pdf = @static_pdf.html_safe.gsub("\n", ' ')
    @static_pdf = render_to_string pdf: 'pdf', inline: @static_pdf, encoding: 'UTF-8'
    respond_to do |format|
      format.html
      format.pdf do
        send_data(@static_pdf, filename: "carbon-footprint-#{Time.current.strftime('%d%m%Y%H%M')}.pdf", type: 'application/pdf')
      end
    end
  end

  private

  def cv_params
    params.require(:cv).permit(
      :name,
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :address,
      :drivers_licence,
      :linkedin,
      :facebook,
      :twitter,
      :github,
      :website,
      :birth_date,
      :sex,
      :main_photo
    )
  end

  def sections_params
    params.require(:section).permit(
      :name,
      :certificates_section,
      :courses_section,
      :educations_section,
      :employments_section,
      :languages_section,
      :references_section,
      :skills_section,
      :interest_section,
      :privacy_policy_sections,
      :description_section,
      :custom_section,
      :vertical_position
    )
  end

end
