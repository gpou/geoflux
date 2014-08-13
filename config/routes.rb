Geoflux::Application.routes.draw do
  namespace :admin do
    resource :dashboard
    resources :estimate_details, :only => [:new, :create, :edit, :update, :destroy]
    resources :customers
    resources :ports
    root 'dashboards#show'
  end
  root 'homes#show'
end
