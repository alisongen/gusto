class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  # GET /ezhfuhef/:restaurant_id
  def set_restaurant
    # call api en utilisant l'restaurant_id pour récupérer les informations du restaurant
    # Avec ces informations je fabrique mon instance SI elle n'existe pas deja
    # restaurant = Restaurant.find_or_create(datas de la reponse api)
    # je redirect_to vers la restaurant_path(restaurant)
  end

  def show
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
    @friends = User.where(id: ids)
    # Récupération des données du restaurant via l'API
    restaurant_data = GetGooglePlaceDetailsService.new(params[:id]).call
    # Création d'un modèle restaurant avec les données récupérées
    @restaurant = Restaurant.find_or_create_by(name: restaurant_data.dig("displayName", "text"), address: restaurant_data.dig("formattedAddress"), category: restaurant_data.dig("primaryTypeDisplayName", "text"), rating: restaurant_data.dig("rating"), phone_number: restaurant_data.dig("nationalPhoneNumber"), website: restaurant_data.dig("websiteUri"))
    respond_to do |format|
      format.html # Rendu pour une page HTML
      format.json { render json: @restaurants } # Permet aussi d'utiliser en API
    end
    # @images = @restaurant.images
    # @image = @images.sample
    @collections = Collection.where(user_id: current_user.id)
    @saved_restaurant = @restaurant
    @saved_restaurants = SavedRestaurant.where(user_id: current_user.id)
    @review = Review.new
    @reviews = Review.all
  end

  def update_collection
    @restaurant = Restaurant.find(params[:restaurant_id])
    @saved_restaurant = SavedRestaurant.find_or_create_by(restaurant: @restaurant, user: current_user)
    @collections = Collection.where(user_id: current_user.id)
    @collections.each do |collect|
      if (params["#{collect.name}"].present? && !SavedRestaurantsCollection.where(saved_restaurant_id: @saved_restaurant.id, collection_id: collect.id).present?)
        @collection = Collection.find(params["#{collect.name}"])
        SavedRestaurantsCollection.create(collection_id: collect.id, saved_restaurant_id: @saved_restaurant.id)
      elsif (SavedRestaurantsCollection.where(saved_restaurant_id: @saved_restaurant.id, collection_id: collect.id).present? && !params["#{collect.name}"].present?)
        @saved_restaurants_collection = SavedRestaurantsCollection.where(saved_restaurant_id: @saved_restaurant.id, collection_id: collect.id)
        @saved_restaurants_collection.first.destroy
      end
    end
    #redirect_to collections_path(name: @collection.name)
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @saved_restaurant = SavedRestaurant.find(params[:format])
    @photo = @saved_restaurant.photos.find(params[:id])
    @photo.destroy
    redirect_to restaurant_path()
  end
end
