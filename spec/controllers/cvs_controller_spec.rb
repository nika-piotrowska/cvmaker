require 'rails_helper'

RSpec.describe CvsController, type: :controller do
  let(:user) { create(:user) }
  let(:cv) { create(:cv, user: user) }

  before { sign_in user }

  describe 'POST #create' do
    it 'creates a cv and redirects to edit' do
      expect {
        post :create, params: { user_id: user.id }
      }.to change(Cv, :count).by(1)

      expect(response).to redirect_to(edit_user_cv_path(user_id: user.id, id: Cv.last.id))
    end
  end

  describe 'PATCH #update' do
    it 'updates a cv' do
      patch :update,
            params: { user_id: user.id, id: cv.id, cv: { first_name: 'Updated' } },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(cv.reload.first_name).to eq('Updated')
    end
  end

  describe 'PATCH #display_personal_information' do
    it 'renders personal information' do
      patch :display_personal_information,
            params: { user_id: user.id, id: cv.id },
            format: :js

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #display_sections' do
    it 'renders sections' do
      patch :display_sections,
            params: { user_id: user.id, id: cv.id },
            format: :js

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #display_styles' do
    it 'renders styles' do
      patch :display_styles,
            params: { user_id: user.id, id: cv.id },
            format: :js

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #set_style' do
    it 'updates the style' do
      patch :set_style,
            params: { user_id: user.id, id: cv.id, cv: { style: 'style2' } },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(cv.reload.style).to eq('style2')
    end
  end

  describe 'GET #style1' do
    it 'renders style1' do
      get :style1, params: { user_id: user.id, id: cv.id }

      expect(response).to have_http_status(:ok)
    end
  end
end
