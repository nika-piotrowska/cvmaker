class CvsController < ApplicationController
  load_and_authorize_resource

  def style1
    @cv = Cv.find(params[:id])
  end

  def index; end

  def create
    cv = Cv.new(email: current_user.email, name: "CV#{current_user.cvs.size + 1}", user_id: current_user.id)
    if cv.save
      redirect_to edit_user_cv_path(user_id: current_user.id, id: cv.id)
    else
      redirect_to dashboard_users_path, notice: t('.notice')
    end
  end

  def edit; end

  def update
    @cv.update(cv_params)
    @section = Section.new
    display_personal_information
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
    pdf_html_string = render_to_body template: "cvs/#{@cv.style}.html.erb", layout: false
    pdf_html_string = render_to_string inline: pdf_html_string, layout: false
    respond_to do |format|
      format.html { render html: pdf_html_string }
      format.pdf { render_pdf pdf_html_string, filename: "#{@cv.name}.pdf" }
    end
  end

  def set_style
    # byebug
    @cv.update(cv_params)
    display_styles
  end

  private

  def render_pdf(pdf_html_string, filename:)
    pdf = Grover.new(pdf_html_string, format: 'A4', printBackground: true).to_pdf
    send_data pdf, filename: filename, type: 'application/pdf'
  end

  def cv_params
    return unless params.key?(:cv)

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
      :main_photo,
      :style
    )
  end

  def sections_params
    return unless params.key?(:section)

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
