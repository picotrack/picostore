Rails.application.routes.draw do
  namespace :api do
    get 'payment/success'
    get 'payment/failure'
  end
  root to: 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'sessions/new'
  post 'sessions/create'
  get 'sessions/destroy'

  resources :users
  
  # Products
  get "products", to: "products#index"
  get "products/:id", to: "products#show"

  # Orders
  get "orders/new", to: "orders#new"
  get "orders/:id", to: "orders#show"
  post "orders", to: "orders#create"

  # Payments
  get "payments/new", to: "payments#new"

  post "email_authentication_requests", to: "email_authentication_requests#create" # API Route
  post "email_authentication_requests/verify", to: "email_authentication_requests#verify"

  get "toss_payments/success", to: "toss_payments#success"
  get "toss_payments/failure", to: "toss_payments#failure"

  namespace :manage do
    resources :products
  end
end
