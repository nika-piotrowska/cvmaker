Rails.application.routes.draw do
  devise_for :users, controllers: {
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }

  resources :users do
    collection do
      get 'dashboard'
    end
    resources :cvs do
      member do
        patch 'display_personal_information'
        patch 'display_styles'
        patch 'display_sections'
        post 'download_pdf'
      end
      resources :sections do
        member do
          patch 'move_section_up'
          patch 'move_section_down'
        end
        resources :certificates do
          member do
            patch 'move_certificate_up'
            patch 'move_certificate_down'
          end
        end
        resources :courses do
          member do
            patch 'move_course_up'
            patch 'move_course_down'
          end
        end
        resources :educations do
          member do
            patch 'move_education_up'
            patch 'move_education_down'
          end
        end
        resources :employments do
          member do
            patch 'move_employment_up'
            patch 'move_employment_down'
          end
        end
        resources :languages do
          member do
            patch 'move_language_up'
            patch 'move_language_down'
          end
        end
        resources :references do
          member do
            patch 'move_reference_up'
            patch 'move_reference_down'
          end
        end
      end
    end
  end

  authenticated :user do
    root to: redirect('/users/dashboard'), as: :authenticated_user_root
  end
  unauthenticated :user do
    devise_scope :user do
      get '/' => 'devise/sessions#new'
    end
  end
end
