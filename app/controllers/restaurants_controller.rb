

class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{params[:place_id]}&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
    response = URI.open(url).read
    @restaurant = JSON.parse(response)["result"]
    @images = @restaurant["photos"]&.map { |photo| "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{photo["photo_reference"]}&key=#{ENV['GOOGLE_PLACES_API_KEY']}" }
    @image = @images.sample if @images.present?
    @collections = Collection.where(user_id: current_user.id)
    @saved_restaurants = SavedRestaurant.where(user_id: current_user.id)
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
end
