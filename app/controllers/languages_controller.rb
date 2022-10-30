class LanguagesController < ApplicationController
  load_and_authorize_resource

  def create
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    Language.create(section_id: @section.id, position: @section.languages.size + 1)
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def update
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    if @language.update(languages_params)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def destroy
    @cv = Cv.find(params[:cv_id])
    @language.destroy
    respond_to do |format|
      format.js { render 'sections/sections_list.js.erb', layout: false }
    end
  end

  def move_language_up
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    up_language = @section.languages.find_by(position: @language.position - 1)
    if up_language.present?
      @language.update(position: @language.position - 1)
      up_language.update(position: up_language.position + 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  def move_language_down
    @cv = Cv.find(params[:cv_id])
    @section = Section.find(params[:section_id])
    down_language = @section.languages.find_by(position: @language.position + 1)
    if down_language.present?
      @language.update(position: @language.position + 1)
      down_language.update(position: down_language.position - 1)
      respond_to do |format|
        format.js { render 'sections/sections_list.js.erb', layout: false }
      end
    end
  end

  private

  def languages_params
    params.require(:language).permit(
      :language,
      :language_level
    )
  end
end
