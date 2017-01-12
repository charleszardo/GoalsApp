Rails.application.routes.draw do
  root "goals#index"

  resources :users, only: [:new, :create, :show, :index]
  resource :session, only: [:new, :create, :destroy]

  resources :goals, only: [:new, :create, :show] do
    member do
      post :complete
      post :incomplete
    end
  end
end
