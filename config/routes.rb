Rails.application.routes.draw do
  root "goals#index"

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :goals, only: [:index]
end
