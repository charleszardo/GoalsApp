Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [:new, :create, :show, :index] do
    resources :comments, only: [:create]
  end

  resource :session, only: [:new, :create, :destroy]

  resources :goals, only: [:new, :create, :show] do
    resources :comments, only: [:create]
    resources :cheers, only: [:create, :destroy]

    member do
      post :complete
      post :incomplete
    end

    collection do
      get :leaderboard
    end
  end
end
