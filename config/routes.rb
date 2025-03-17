Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :restaurants, only: :show do
    resources :collections, only: [:new, :create, :index]
    resources :reviews, only: [:create]
    resources :saved_restaurants, only: [:create]
  end

  resources :saved_restaurants, only: [:update]

  resources :restaurants do
      patch "update_collection", to: "restaurants#update_collection", as: :collection
  end

  resources :collections

  resources :friendships, except: %i[edit update new]
  get "friendships", to: "friendship#new"

  patch "friendships/:id/accept", to: "friendships#accept", as: :accept
  patch "friendships/:id/decline", to: "friendships#decline", as: :decline

  get "dashboard", to: "pages#dashboard"
  get "actuality", to: "pages#actuality"
end
