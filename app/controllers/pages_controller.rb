class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # @collection.user = @user
    # @collection = Collection.find(name: "Favorites")
    # J'assigne à ma variable d'instance "@restaurants" les restaurants correspondant à ma recherche
    # si une valeur "query" est présente dans mes params
    @restaurants = Restaurant.search_by_name(params[:query]) if params[:query].present?
    # J'assigne à ma variable d'instance "@user" le "current_user"
    @user = User.first
    # J'associe à ma variable "@saved_restaurants" les "saved_restaurants" de mon "@user"
    @saved_restaurants = @user.saved_restaurants
    # CODE TEST
    @saved_restaurant = @saved_restaurants.first
  end

  def dashboard
    # J'assigne à ma variable d'instance "@user" le "current_user"
    @user = User.first
    # Récupération de tout les saved_restaurants de mon @user
    @saved_restaurants = @user.saved_restaurants
    # Récupération des collections de mon @user
    @collections = @user.collections
  end
end
