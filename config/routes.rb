Rails.application.routes.draw do

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

	resources :order_items, only: [:create, :update, :destroy]

	root to: "books#best_sellers"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
end
