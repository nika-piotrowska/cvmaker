require 'rails_helper'

RSpec.describe EmploymentsController, type: :controller do
  let(:user) { create(:user) }
  let(:cv) { create(:cv, user: user) }
  let(:section) { create(:section, cv: cv) }

  before { sign_in user }

  describe 'POST #create' do
    it 'creates an employment entry' do
      expect {
        post :create, params: { user_id: user.id, cv_id: cv.id, section_id: section.id }, format: :js
      }.to change(Employment, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #update' do
    it 'updates an employment entry' do
      employment = create(:employment, section: section)

      patch :update,
            params: {
              user_id: user.id,
              cv_id: cv.id,
              section_id: section.id,
              id: employment.id,
              employment: {
                city: 'Updated City',
                'end_date(1i)' => '2021',
                'end_date(2i)' => '6'
              }
            },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(employment.reload.city).to eq('Updated City')
    end
  end

  describe 'DELETE #destroy' do
    it 'removes an employment entry' do
      employment = create(:employment, section: section)

      expect {
        delete :destroy,
               params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: employment.id },
               format: :js
      }.to change(Employment, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #move_employment_up' do
    it 'moves an employment entry up' do
      create(:employment, section: section, position: 1)
      employment = create(:employment, section: section, position: 2)

      patch :move_employment_up,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: employment.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(employment.reload.position).to eq(1)
    end
  end

  describe 'PATCH #move_employment_down' do
    it 'moves an employment entry down' do
      employment = create(:employment, section: section, position: 1)
      create(:employment, section: section, position: 2)

      patch :move_employment_down,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: employment.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(employment.reload.position).to eq(2)
    end
  end
end
