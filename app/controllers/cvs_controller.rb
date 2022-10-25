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
      respond_to do |format|
        format.js { render 'cvs/sections.js.erb', layout: false }
      end
    else
      respond_to do |format|
        format.js { render 'cvs/personal_information.js.erb', layout: false }
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
