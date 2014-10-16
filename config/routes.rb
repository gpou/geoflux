Geoflux::Application.routes.draw do
  namespace :admin do
    resource :dashboard
    resources :estimates do
      member do
        patch :add_estimate_requests
        get :send_estimate_requests
        patch :update_email
        patch :update_comments
        get :change_state
      end
      resources :estimate_requests do
        member do
          get :send_request
          get :change_state
          get :reload_email
        end
      end
    end
    resources :customers
    resources :ports
    resources :countries
    resources :carriers do
      resources :contacts do
        resources :journey_contacts
      end
    end

    resources :orders do
      member do
        get :change_state
        patch :update_comments
      end
      collection do
        get :save_estimate
      end
    end

    root 'dashboards#show'
  end
  root 'homes#show'
end
