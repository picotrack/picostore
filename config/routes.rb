Rails.application.routes.draw do
  namespace :manage do
    resources :products
  end
end
