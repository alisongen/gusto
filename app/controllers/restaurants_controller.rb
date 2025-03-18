

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
    @restaurant = Restaurant.find(params[:id])
    @images = @restaurant.images
    @image = @images.sample
    @collections = Collection.where(user_id: current_user.id)
    @saved_restaurant = SavedRestaurant.where(restaurant_id: params[:id], user_id: current_user.id).first
    @saved_restaurants = SavedRestaurant.where(user_id: current_user.id)
    @review = Review.new
    @reviews = Review.all
  end

  def update_collection
    @restaurant = Restaurant.find(params[:restaurant_id])
    @collection = Collection.find(params[:collection_id])
    @saved_restaurant = SavedRestaurant.find_or_create_by(restaurant: @restaurant, user: current_user)
    @collection.saved_restaurants << @saved_restaurant
    @collection.save!
    #redirect_to collections_path(name: @collection.name)
    redirect_to dashboard_path
  end

  def destroy
    @saved_restaurant = SavedRestaurant.find(params[:format])
    @photo = @saved_restaurant.photos.find(params[:id])
    @photo.destroy
    redirect_to restaurant_path()
  end
end
