Rails.application.routes.draw do

  get 'order/new'
  get 'order/create'
  get 'order/update'
  get 'order/destroy'

  get 'addresses/new'
  get 'addresses/create'
  get 'addresses/update'
  get 'addresses/destroy'
  resources :addresses

  get 'checkout/address'
  get 'checkout/delivery'
  get 'checkout/payment', to: 'credit_cards#new'
  get 'checkout/confirm'
  get 'checkout/complete'
  # get 'credit_cards/new'
  
  resources :credit_cards, only: [:new, :create, :update, :destroy]

  devise_for :users

	resources :books do
		collection do
			get 'best_sellers'
		end
		resources :ratings, only: [:new, :create]
	end
	
	resources :categories, only: [:show]

	resource :cart, only: [:show]	
	get 'cart/clear', to: 'carts#clear', as: 'clear_cart'

  resources :order
	resources :order_items, only: [:create, :update, :destroy]

	root to: "books#best_sellers"
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
