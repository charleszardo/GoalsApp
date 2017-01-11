Rails.application.routes.draw do
  root "goals#index"

  resources :users, only: [:new, :create]

  resources :goals, only: [:index]
end
