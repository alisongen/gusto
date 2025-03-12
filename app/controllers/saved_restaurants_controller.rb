class SavedRestaurantsController < ApplicationController
  def index
    SavedRestaurant.all
  end

  def new
    @saved_restaurant = SavedRestaurant.new
  end

  def create
    @user = current_user
    @saved_restaurant = SavedRestaurant.new(saved_restaurant_params)
    @saved_restaurant.user_id = @user.id
    @saved_restaurant.save
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def saved_restaurant_params
    params.require(:saved_restaurant).permit(:user_id)
  end
end
