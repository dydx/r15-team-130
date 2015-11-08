Rails.application.routes.draw do
  devise_for :users
  resources :conferences
  root 'conferences#index'
end
