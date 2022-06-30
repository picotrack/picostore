Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'sessions/new'
  post 'sessions/create'
  get 'sessions/destroy'

  resources :users
  
  # Products
  get "products/:id", to: "products#show"
  get "products/:product_id/order/ask-email", to: "orders#ask_email"
  get "products/:product_id/order/payment", to: "orders#payment"

  namespace :manage do
    resources :products
  end

  namespace :api do
    post "email_authentication/request_email_authentication", to: "email_authentication#request_email_authentication"
    post "email_authentication/verify_email_authentication", to: "email_authentication#verify_email_authentication"
  end
end
