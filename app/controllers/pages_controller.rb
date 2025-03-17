class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: []

  def home
    # J'assigne à ma variable d'instance "@user" le "current_user"
    @user = current_user
    # J'assigne à ma variable d'instance "@restaurants" les restaurants correspondant à ma recherche
    # si une valeur "query" est présente dans mes params
    @restaurants = GooglePlacesService.new(params[:query]).results if params[:query].present?
    respond_to do |format|
      format.html # Rendu pour une page HTML
      format.json { render json: @restaurants } # Permet aussi d'utiliser en API
    end
    # @collection = @user.collections.where(name: "Favoris")
    # @saved_restaurants = @user.saved_restaurants
  end

  def dashboard
    # J'assigne à ma variable d'instance "@user" le "current_user"
    @user = current_user
    # Récupération de tout les saved_restaurants de mon @user
    @restaurants = @user.restaurants
    # Récupération des collections de mon @user
    @collections = @user.collections
    @collection = @user.collections.where(name: "Favoris").first
  end
end
