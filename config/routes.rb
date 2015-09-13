Rails.application.routes.draw do
  resources :trails
  root 'trails#index'
end
