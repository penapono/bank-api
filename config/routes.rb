Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :accounts, only: [:index, :create, :update]
      resources :contributions, only: [:index, :create]
      resources :histories, only: :index
      resources :legal_people, only: [:index, :create]
      resources :natural_people, only: [:index, :create]
      resources :transfers, only: [:index, :create]
      resources :rollbacks, only: :create
    end
  end
end
