Rails.application.routes.draw do
  get 'public_recipes/index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, except: :show
  get 'users/:id', to: 'users#show', as: :user_show, constraints: { id: /\d+/ }
  
  resources :recipes do
    resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]

    patch 'toggle_public', on: :member
  end
  
  authenticated :user do
    root 'public_recipes#index', as: :authenticated_root
  end

  unauthenticated :user do
    root 'public_recipes#index', as: :unauthenticated_root
  end

  resources :foods

  get 'shopping_list' => 'shopping_lists#index', as: :shopping_list

  get "up" => "rails/health#show", as: :rails_health_check

  root "public_recipes#index"
end