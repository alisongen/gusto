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

  def feed
    @user = current_user
    # trouver les relations entre nous et qqun d'autre qui ont le statut accepté
    all_accepted_friendships = Friendship.where(status: 1).where(user: current_user).or(Friendship.where(status: 1).where(friend: current_user))
    # Sortir les id de ceux-là
    ids = all_accepted_friendships.map do |friendship|
      if friendship.user == current_user
        friendship.friend.id
      else
        friendship.user.id
      end
    end
    #
    friends = User.where(id: ids)
    # pouvoir sortir tous les saved restaurants de ces amis
    @friends_saved_restaurants = SavedRestaurant.where(user_id: friends.ids)
    # pouvoir sortir toutes les reviews de ces amis
    @friends_reviews = Review.where(user_id: friends.ids)
    # pouvoir sortir toutes les photos de ces amis
    # @friends_photos =
  end
end
