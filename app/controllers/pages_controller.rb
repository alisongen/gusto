class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: []

  def home
    # J'assigne à ma variable d'instance "@restaurants" les restaurants correspondant à ma recherche
    # si une valeur "query" est présente dans mes params
    @restaurants = Restaurant.search_by_name(params[:query]) if params[:query].present?
    # J'assigne à ma variable d'instance "@user" le "current_user"
    @user = current_user
    @collection = @user.collections.where(name: "Favoris").first
    @saved_restaurants = @user.saved_restaurants
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
    all_friendships = Friendship.where(status: 1).where(user: current_user).or(Friendship.where(friend: current_user))
    ids = all_friendships.map do |friendship|
      if friendship.user == current_user
        friendship.friend.id
      else
        friendship.user.id
      end
    end

    friends = User.where(id: ids)
    # trouver les amis qui ont le statut accepté
    # Sortir les id de ceux-là
    # pouvoir sortir tous les saved restaurants de ces amis
    @saved_restaurants = SavedRestaurants.where(user_id: friends_id)

  end
end
