Rails.application.routes.draw do
  devise_for :trainers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pokemons#index'
  resources :pokemons, only: [:index]
  resources :favorites, only: %i[create destroy]
end
