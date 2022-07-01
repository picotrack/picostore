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
  post "products/:product_id/order/create", to: "orders#create"
  get "orders/:id", to: "orders#show"

  namespace :manage do
    resources :products
  end

  namespace :api do
    post "email_authentication/request_email_authentication", to: "email_authentication#request_email_authentication"
    post "email_authentication/verify_email_authentication", to: "email_authentication#verify_email_authentication"

    get "payments/success", to: "payment#success"
    get "payments/failure", to: "payment#failure"
  end
end
