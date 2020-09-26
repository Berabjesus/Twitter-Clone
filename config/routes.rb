Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :tweets
  resources :users, only: [:show]
  root to:'tweets#index'
end
