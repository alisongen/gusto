class SavedRestaurantsController < ApplicationController
  def new

  end

  def create

  end

  def index
    SavedRestaurant.all
  end

  def edit

  end

  def update
    @saved_restaurant = SavedRestaurant.first
  end

  def delete

  end
end
