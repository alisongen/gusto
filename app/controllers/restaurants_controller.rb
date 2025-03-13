class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @images = @restaurant.images


    # @collections = Collection.where(user: current_user)
    # @collection = Collection.new
    # @collection.saved_restaurant = @restaurant
  end
end
