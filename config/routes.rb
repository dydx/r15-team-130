Rails.application.routes.draw do
  resources :conferences
  root 'conferences#index'
end
