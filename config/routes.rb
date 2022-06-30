Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'sessions/new'
  post 'sessions/create'
  get 'sessions/destroy'

  resources :users
  
  # Products
  get "products/:id", to: "products#show"
  get "products/:product_id/order", to: "orders#new"

  namespace :manage do
    resources :products
  end
end
