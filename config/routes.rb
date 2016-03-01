Rails.application.routes.draw do
  
  get 'checkout/address'
  get 'checkout/delivery'
  get 'checkout/payment', to: 'credit_cards#new'
  get 'checkout/confirm'
  get 'checkout/complete'
  
  resources :credit_cards, only: [:new, :create, :update, :destroy]

  devise_for :users
  resources :users

  resources :books do
    collection do
      get 'best_sellers'
    end
    resources :ratings, only: [:new, :create]
  end
  
  resources :categories, only: [:show]

  resource :cart, only: [:show] 
  get 'cart/clear', to: 'carts#clear', as: 'clear_cart'

  get '/settings', to: 'settings#show', as: 'settings'

  resources :orders
  resources :order_items, only: [:create, :update, :destroy]

  root to: "books#best_sellers"
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
