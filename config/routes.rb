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
  get "products/:product_id/order/new", to: "orders#new"
  get "orders/:id", to: "orders#show"

  post "email_authentication_requests", to: "email_authentication_request#create" # API Route
  post "email_authentication_requests/verify", to: "email_authentication_request#verify"

  get "toss_payments/success", to: "toss_payment#success"
  get "toss_payments/failure", to: "toss_payment#failure"

  namespace :manage do
    resources :products
  end
end
