class LanguagesController < ApplicationController
  load_and_authorize_resource
  before_action :set_cv_and_section

  def create
    Language.create(section_id: @section.id, position: @section.languages.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    if @language.update(languages_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @language.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_language_up
    if @language.move_up
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_language_down
    if @language.move_down
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

  def languages_params
    return unless params.key?(:language)

    params.require(:language).permit(
      :language,
      :language_level
    )
  end
end
