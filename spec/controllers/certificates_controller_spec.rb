require 'rails_helper'

RSpec.describe CertificatesController, type: :controller do
  let(:user) { create(:user) }
  let(:cv) { create(:cv, user: user) }
  let(:section) { create(:section, cv: cv) }

  before { sign_in user }

  describe 'POST #create' do
    it 'creates a certificate' do
      expect {
        post :create, params: { user_id: user.id, cv_id: cv.id, section_id: section.id }, format: :js
      }.to change(Certificate, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #update' do
    it 'updates a certificate' do
      certificate = create(:certificate, section: section)

      patch :update,
            params: {
              user_id: user.id,
              cv_id: cv.id,
              section_id: section.id,
              id: certificate.id,
              certificate: { name: 'Updated Certificate' }
            },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(certificate.reload.name).to eq('Updated Certificate')
    end
  end

  describe 'DELETE #destroy' do
    it 'removes a certificate' do
      certificate = create(:certificate, section: section)

      expect {
        delete :destroy,
               params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: certificate.id },
               format: :js
      }.to change(Certificate, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #move_certificate_up' do
    it 'moves a certificate up' do
      create(:certificate, section: section, position: 1)
      certificate = create(:certificate, section: section, position: 2)

      patch :move_certificate_up,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: certificate.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(certificate.reload.position).to eq(1)
    end
  end

  describe 'PATCH #move_certificate_down' do
    it 'moves a certificate down' do
      certificate = create(:certificate, section: section, position: 1)
      create(:certificate, section: section, position: 2)

      patch :move_certificate_down,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: certificate.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(certificate.reload.position).to eq(2)
    end
  end
end
