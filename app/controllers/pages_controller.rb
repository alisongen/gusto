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
    #
    @collection = @user.collections.where(name: "Favoris").first
  end

  def dashboard
    # J'assigne à ma variable d'instance "@user" le "current_user"
    @user = current_user
    # Récupération de tout les saved_restaurants de mon @user
    @restaurants = @user.restaurants
    # Récupération des collections de mon @user
    @collections = @user.collections
  end
end
