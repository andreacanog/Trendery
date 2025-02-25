Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:create, :show, :update, :destroy]
    resources :products, only: [:index, :create, :show, :update, :destroy]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resource :session, only: [:create, :destroy]
    resources :orders, only: [:index, :show, :create, :update, :destroy]
    resource :cart, only: [:show, :destroy]
    resources :order_items, only: [:create, :show, :update, :destroy]
  end

  get '*path', to: 'static_pages#frontend'
end
