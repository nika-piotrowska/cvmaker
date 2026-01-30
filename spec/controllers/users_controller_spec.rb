require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'GET #show' do
    it 'renders show' do
      get :show, params: { id: user.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #index' do
    it 'renders index' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #dashboard' do
    it 'renders dashboard' do
      create(:cv, user: user)

      get :dashboard

      expect(response).to have_http_status(:ok)
    end
  end
end
