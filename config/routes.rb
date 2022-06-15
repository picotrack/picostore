Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'sessions/new'
  post 'sessions/create'
  get 'sessions/destroy'

  resources :users
  
  # Products
  get "products/:id", to: "products#show"

  namespace :manage do
    resources :products
  end
end
