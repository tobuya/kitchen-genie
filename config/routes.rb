Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "public#homepage"

  resources :recipes, only: [:index, :new, :show, :create, :destroy]
  resources :foods, only: [:index, :new, :create, :destroy]
end
