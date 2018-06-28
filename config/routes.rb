Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :accounts
      resources :contributions
      resources :histories, only: :index
      resources :legal_people
      resources :natural_people
      resources :transfers
    end
  end
end
