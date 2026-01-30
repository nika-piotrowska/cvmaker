require 'rails_helper'

RSpec.describe ReferencesController, type: :controller do
  let(:user) { create(:user) }
  let(:cv) { create(:cv, user: user) }
  let(:section) { create(:section, cv: cv) }

  before { sign_in user }

  describe 'POST #create' do
    it 'creates a reference' do
      expect {
        post :create, params: { user_id: user.id, cv_id: cv.id, section_id: section.id }, format: :js
      }.to change(Reference, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #update' do
    it 'updates a reference' do
      reference = create(:reference, section: section)

      patch :update,
            params: {
              user_id: user.id,
              cv_id: cv.id,
              section_id: section.id,
              id: reference.id,
              reference: { company: 'Updated Company' }
            },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(reference.reload.company).to eq('Updated Company')
    end
  end

  describe 'DELETE #destroy' do
    it 'removes a reference' do
      reference = create(:reference, section: section)

      expect {
        delete :destroy,
               params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: reference.id },
               format: :js
      }.to change(Reference, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #move_reference_up' do
    it 'moves a reference up' do
      create(:reference, section: section, position: 1)
      reference = create(:reference, section: section, position: 2)

      patch :move_reference_up,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: reference.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(reference.reload.position).to eq(1)
    end
  end

  describe 'PATCH #move_reference_down' do
    it 'moves a reference down' do
      reference = create(:reference, section: section, position: 1)
      create(:reference, section: section, position: 2)

      patch :move_reference_down,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: reference.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(reference.reload.position).to eq(2)
    end
  end
end
