class SavedRestaurantsController < ApplicationController

  def index
    SavedRestaurant.all
  end

  def edit

  end

  def update
    @saved_restaurant = SavedRestaurant.first
  end

end
