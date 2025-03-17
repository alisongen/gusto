Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :restaurants, only: :show do
    # resources :collections, only: [:new, :create, :index]
    resources :collections, only: [:index]
  end

  resources :restaurants do
    patch "update_collection", to: "restaurants#update_collection", as: :collection
  end

  # À VÉRIFIER
  resources :collections, only: [:new, :create, :index, :show]

  resources :friendships, except: %i[edit update new]
  get "friendships", to: "friendship#new"

  patch "friendships/:id/accept", to: "friendships#accept", as: :accept
  patch "friendships/:id/decline", to: "friendships#decline", as: :decline

  get "dashboard", to: "pages#dashboard"
  get "feed", to: "pages#feed"
end
