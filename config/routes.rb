Rails.application.routes.draw do

  get 'orders/new'
  get 'orders/create'
  get 'orders/update'
  get 'orders/destroy'

  resources :addresses
  
  get 'checkout/address'
  get 'checkout/delivery'
  get 'checkout/payment', to: 'credit_cards#new'
  get 'checkout/confirm'
  get 'checkout/complete'
  # get 'credit_cards/new'
  
  resources :credit_cards, only: [:new, :create, :update, :destroy]

  devise_for :users
  resources :users
  # get 'user/:id/settings', to: 'users#settings', as: 'user_settings'

  resources :books do
    collection do
      get 'best_sellers'
    end
    resources :ratings, only: [:new, :create]
  end
  
  resources :categories, only: [:show]

  resource :cart, only: [:show] 
  get 'cart/clear', to: 'carts#clear', as: 'clear_cart'

  # resource :settings, only: [:show]
  get '/settings', to: 'settings#show', as: 'settings'

  resources :orders
	resources :order_items, only: [:create, :update, :destroy]

	root to: "books#best_sellers"
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
