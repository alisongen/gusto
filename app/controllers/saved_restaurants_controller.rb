class SavedRestaurantsController < ApplicationController

  def index
    SavedRestaurant.all
  end

  def edit

  end

  def update
    @saved_restaurant = SavedRestaurant.first
    if @saved_restaurant.update(saved_restaurant_params)
      redirect_to root_path, notice: "Photo ajoutée avec succès !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

private

  def saved_restaurant_params
    params.require(:saved_restaurant).permit(photos: [])
  end

end
