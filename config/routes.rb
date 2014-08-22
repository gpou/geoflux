Geoflux::Application.routes.draw do
  namespace :admin do
    resource :dashboard
    resources :estimates
    resources :customers
    resources :ports
    resources :countries
    resources :carriers
    root 'dashboards#show'
  end
  root 'homes#show'
end
