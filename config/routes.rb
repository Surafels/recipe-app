Rails.application.routes.draw do
  get 'public_recipes/index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, except: :show
  get 'users/:id', to: 'users#show', as: :user_show, constraints: { id: /\d+/ }
  resources :recipes do
    resources :recipe_foods
    patch 'toggle_public', on: :member
  end

  resources :foods
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "public_recipes#index"
end
