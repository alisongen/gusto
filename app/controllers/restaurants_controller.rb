class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @images = @restaurant.images
    @image = @images.sample
    @collections = Collection.where(user_id: current_user.id)
    @saved_restaurants = SavedRestaurant.where(user_id: current_user.id)
  end

  def update_collection
    @restaurant = Restaurant.find(params[:restaurant_id])
    @collection = Collection.find(params[:collection_id])
    @saved_restaurant = SavedRestaurant.find_or_create_by(restaurant: @restaurant, user: current_user)
    @collection.saved_restaurants << @saved_restaurant
    @collection.save!
    redirect_to collections_path(name: @collection.name)
  end
end
