class PagesController < ApplicationController

  def home
    # J'assigne à ma variable d'instance "@user" le "current_user"
    @user = current_user
    @saved_restaurants = @user.saved_restaurants
    # J'assigne à ma variable d'instance "@restaurants" les restaurants correspondant à ma recherche
    # si une valeur "query" est présente dans mes params
    @restaurants = GetGooglePlacesDataService.new(params[:query]).call if params[:query].present?
    respond_to do |format|
      format.html # Rendu pour une page HTML
      format.json { render json: @restaurants } # Permet aussi d'utiliser en API
    end
    @collection = @user.collections.where(name: "Favoris")
    @saved_restaurants = @user.saved_restaurants
    @friends = @user.friends
    @friends_restaurants = []
    @reco_restaurants = []
    @friends.each do |friend|
      @friends_restaurants += friend.saved_restaurants
    end
    @friends_restaurants.each do |restaurant|
      @info_restaurant = Restaurant.find(restaurant.restaurant_id)
      @reco_restaurants << @info_restaurant
    end
    @reco_restaurants.uniq!
  end

  def dashboard
    # J'assigne à ma variable d'instance "@user" le "current_user"
    @user = current_user
    # Récupération de tout les saved_restaurants de mon @user
    @restaurants = @user.restaurants
    # Récupération des collections de mon @user
    @collections = @user.collections
    @collection = @user.collections.where(name: "Favoris").first
    @new_collection = Collection.new
    @colors = [
      "#4B3B47", # Eggplant
      "#FFBD33", # Orange
      "#FFD133", # Yellow
      "#A3E635", # Lime Green
      "#33FF57", # Green
      "#33FFBD", # Mint
      "#33D1FF", # Sky Blue
      "#3357FF", # Blue
      "#8A33FF", # Purple
      "#FF33F0", # Pink
      "#FF3380", # Hot Pink
      "#FF3366"  # Red
    ]
    @emojis = [ "🍔", "🥞", "🧁", "🍣", "☕️", "🥗", "🍻", "🥩", "🌯", "💙", "🎉", "🍽️" ]
  end

  def switch_window
    @tab = params[:tab_name]
    @collections = current_user.collections
    respond_to(&:turbo_stream)
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
    # pouvoir sortir tous les saved restaurants de ces amis en antéchrono
    @friends_saved_restaurants = SavedRestaurant.where(user_id: friends.ids).includes(:collections).order(created_at: :desc)
    # pouvoir sortir toutes les reviews de ces amis en antéchrono
    @friends_reviews = Review.where(user_id: friends.ids).order(created_at: :desc)
    # pouvoir sortir toutes les photos de ces amis en antéchrono
    @friends_photos = @friends_saved_restaurants.map do |saved_restaurant|
      saved_restaurant.photos.map do |photo|
        { photo: photo, saved_restaurant: saved_restaurant, created_at: photo.created_at }
      end
    end.flatten
    # Concaténer les arrays et les trier par date de création
    @feed_items = (@friends_saved_restaurants + @friends_reviews + @friends_photos).sort_by { |item| item[:created_at] || item.created_at }.reverse
  end
end
