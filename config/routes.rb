Geoflux::Application.routes.draw do
  namespace :admin do
    resource :dashboard
    resources :estimates do
      resources :estimate_requests do
        collection do
          get :reload
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

    root 'dashboards#show'
  end
  root 'homes#show'
end
