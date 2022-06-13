Rails.application.routes.draw do
  get 'sessions/new'
  post 'sessions/create'
  get 'sessions/destroy'

  namespace :manage do
    resources :products
  end
end
