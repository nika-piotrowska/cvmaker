require 'rails_helper'

RSpec.describe EducationsController, type: :controller do
  let(:user) { create(:user) }
  let(:cv) { create(:cv, user: user) }
  let(:section) { create(:section, cv: cv) }

  before { sign_in user }

  describe 'POST #create' do
    it 'creates an education entry' do
      expect {
        post :create, params: { user_id: user.id, cv_id: cv.id, section_id: section.id }, format: :js
      }.to change(Education, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #update' do
    it 'updates an education entry' do
      education = create(:education, section: section)

      patch :update,
            params: {
              user_id: user.id,
              cv_id: cv.id,
              section_id: section.id,
              id: education.id,
              education: {
                city: 'Updated City',
                'end_date(1i)' => '2022',
                'end_date(2i)' => '2'
              }
            },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(education.reload.city).to eq('Updated City')
    end
  end

  describe 'DELETE #destroy' do
    it 'removes an education entry' do
      education = create(:education, section: section)

      expect {
        delete :destroy,
               params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: education.id },
               format: :js
      }.to change(Education, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #move_education_up' do
    it 'moves an education entry up' do
      create(:education, section: section, position: 1)
      education = create(:education, section: section, position: 2)

      patch :move_education_up,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: education.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(education.reload.position).to eq(1)
    end
  end

  describe 'PATCH #move_education_down' do
    it 'moves an education entry down' do
      education = create(:education, section: section, position: 1)
      create(:education, section: section, position: 2)

      patch :move_education_down,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: education.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(education.reload.position).to eq(2)
    end
  end
end
