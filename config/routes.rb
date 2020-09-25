Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :tweets
  root to:'tweets#index'
end
