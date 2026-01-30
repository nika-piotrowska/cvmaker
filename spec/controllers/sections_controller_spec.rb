require 'rails_helper'

RSpec.describe SectionsController, type: :controller do
  let(:user) { create(:user) }
  let(:cv) { create(:cv, user: user) }

  before { sign_in user }

  describe 'POST #create' do
    it 'creates a section' do
      expect {
        post :create,
             params: {
               user_id: user.id,
               cv_id: cv.id,
               cv: { name: :courses_section, horizontal_position: :main_body }
             },
             format: :js
      }.to change(Section, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #update' do
    it 'updates a section' do
      section = create(:section, cv: cv, horizontal_position: :main_body)

      patch :update,
            params: {
              user_id: user.id,
              cv_id: cv.id,
              id: section.id,
              section: { custom_name: 'Updated Section', horizontal_position: :side_body }
            },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(section.reload.custom_name).to eq('Updated Section')
    end
  end

  describe 'DELETE #destroy' do
    it 'removes a section' do
      section = create(:section, cv: cv)

      expect {
        delete :destroy,
               params: { user_id: user.id, cv_id: cv.id, id: section.id },
               format: :js
      }.to change(Section, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #move_section_up' do
    it 'moves a section up' do
      create(:section, cv: cv, vertical_position: 1, horizontal_position: :main_body)
      section = create(:section, cv: cv, vertical_position: 2, horizontal_position: :main_body)

      patch :move_section_up,
            params: { user_id: user.id, cv_id: cv.id, id: section.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(section.reload.vertical_position).to eq(1)
    end
  end

  describe 'PATCH #move_section_down' do
    it 'moves a section down' do
      section = create(:section, cv: cv, vertical_position: 1, horizontal_position: :main_body)
      create(:section, cv: cv, vertical_position: 2, horizontal_position: :main_body)

      patch :move_section_down,
            params: { user_id: user.id, cv_id: cv.id, id: section.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(section.reload.vertical_position).to eq(2)
    end
  end
end
