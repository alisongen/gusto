class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @collections = Collection.where(user_id: current_user.id)
  end

  def update_collection
    @restaurant = Restaurant.find(params[:restaurant_id])
    @collection = Collection.find(params[:collection_id])
    @saved_restaurant = SavedRestaurant.find_or_create_by(restaurant: @restaurant, user: current_user)
    @collection.saved_restaurants << @saved_restaurant
    # TODO: Faire le redirection
  end
end
