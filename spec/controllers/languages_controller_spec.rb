require 'rails_helper'

RSpec.describe LanguagesController, type: :controller do
  let(:user) { create(:user) }
  let(:cv) { create(:cv, user: user) }
  let(:section) { create(:section, cv: cv) }

  before { sign_in user }

  describe 'POST #create' do
    it 'creates a language' do
      expect {
        post :create, params: { user_id: user.id, cv_id: cv.id, section_id: section.id }, format: :js
      }.to change(Language, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #update' do
    it 'updates a language' do
      language = create(:language, section: section)

      patch :update,
            params: {
              user_id: user.id,
              cv_id: cv.id,
              section_id: section.id,
              id: language.id,
              language: { language: 'Updated Language', language_level: 'b2' }
            },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(language.reload.language).to eq('Updated Language')
    end
  end

  describe 'DELETE #destroy' do
    it 'removes a language' do
      language = create(:language, section: section)

      expect {
        delete :destroy,
               params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: language.id },
               format: :js
      }.to change(Language, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #move_language_up' do
    it 'moves a language up' do
      create(:language, section: section, position: 1)
      language = create(:language, section: section, position: 2)

      patch :move_language_up,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: language.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(language.reload.position).to eq(1)
    end
  end

  describe 'PATCH #move_language_down' do
    it 'moves a language down' do
      language = create(:language, section: section, position: 1)
      create(:language, section: section, position: 2)

      patch :move_language_down,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: language.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(language.reload.position).to eq(2)
    end
  end
end
