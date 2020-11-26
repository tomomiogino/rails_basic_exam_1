Rails.application.routes.draw do
  root to: 'tops#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
end
