require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:user) { create(:user) }
  let(:cv) { create(:cv, user: user) }
  let(:section) { create(:section, cv: cv) }

  before { sign_in user }

  describe 'POST #create' do
    it 'creates a course' do
      expect {
        post :create, params: { user_id: user.id, cv_id: cv.id, section_id: section.id }, format: :js
      }.to change(Course, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #update' do
    it 'updates a course' do
      course = create(:course, section: section)

      patch :update,
            params: {
              user_id: user.id,
              cv_id: cv.id,
              section_id: section.id,
              id: course.id,
              course: {
                name: 'Updated Course',
                'end_date(1i)' => '2023',
                'end_date(2i)' => '1'
              }
            },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(course.reload.name).to eq('Updated Course')
    end
  end

  describe 'DELETE #destroy' do
    it 'removes a course' do
      course = create(:course, section: section)

      expect {
        delete :destroy,
               params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: course.id },
               format: :js
      }.to change(Course, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #move_course_up' do
    it 'moves a course up' do
      create(:course, section: section, position: 1)
      course = create(:course, section: section, position: 2)

      patch :move_course_up,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: course.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(course.reload.position).to eq(1)
    end
  end

  describe 'PATCH #move_course_down' do
    it 'moves a course down' do
      course = create(:course, section: section, position: 1)
      create(:course, section: section, position: 2)

      patch :move_course_down,
            params: { user_id: user.id, cv_id: cv.id, section_id: section.id, id: course.id },
            format: :js

      expect(response).to have_http_status(:ok)
      expect(course.reload.position).to eq(2)
    end
  end
end
