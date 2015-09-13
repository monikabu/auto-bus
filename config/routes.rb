Rails.application.routes.draw do
  resources :trails
  resources :weather
  root 'trails#index'
end
