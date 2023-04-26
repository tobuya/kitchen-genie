Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "public#homepage"

  resources :recipes, only: [:index, :new, :show, :create, :update, :destroy] do
    resources :recipe_foods, only: [:new, :create, :destroy], path: "ingredient"
  end
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :public_recipes, only: [:index]
end
