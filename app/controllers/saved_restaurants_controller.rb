class SavedRestaurantsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @saved_restaurant = SavedRestaurant.new
    @saved_restaurant.user_id = current_user.id
    @saved_restaurant.restaurant = @restaurant
    @saved_restaurant.save
    if @saved_restaurant.save
      redirect_to restaurant_path(@restaurant), notice: "Restaurant ajouté aux favoris !"
    else
      redirect_back fallback_location: root_path, alert: "Erreur lors de l'ajout."
    end
  end

  def edit
  end

  def update
  end

  def delete
  end
end
