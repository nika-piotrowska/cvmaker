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
      resources :sections do
        resources :certificates do
        end
        resources :courses do
        end
        resources :educations do
        end
        resources :employments do
        end
        resources :languages do
        end
        resources :references do
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
