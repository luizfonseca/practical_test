Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/cart', to: 'carts#show', as: :cart

  resources :products, only: [:index, :show] do 
    member do 
        post 'cart/add', to: 'carts#add_to_cart', as: :cart_add
        put 'cart/increase', to: 'carts#increase_quantity', as: :cart_increase
        put 'cart/decrease', to: 'carts#decrease_quantity', as: :cart_decrease
    end
  end

  root to: "products#index"
end
