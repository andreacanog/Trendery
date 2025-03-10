Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :cart, only: [:show, :destroy]
      resources :cart_items, only: [:index, :create, :update, :destroy]
      resources :order_items, only: [:create, :show, :update, :destroy]
      resources :orders, only: [:index, :show, :create, :update, :destroy]
      resources :products, only: [:index, :create, :show, :update, :destroy]
      resource :session, only: [:create, :destroy]
      resources :users, only: [:create, :show, :update, :destroy]
    end
  end

  get '*path', to: 'static_pages#frontend'
end
