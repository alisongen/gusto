Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :restaurants, only: :show
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :collections

  resources :friendships, except: %i[edit update new]
  get "friendships", to: "friendship#new"

  patch "friendships/:id/accept", to: "friendships#accept", as: :accept
  patch "friendships/:id/decline", to: "friendships#decline", as: :decline

  get "dashboard", to: "pages#dashboard"
  get "actuality", to: "pages#actuality"
end
