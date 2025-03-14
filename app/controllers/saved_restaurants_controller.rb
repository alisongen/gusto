class SavedRestaurantsController < ApplicationController
  def create
    # Récupération de l'ID Restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    # Création du saved restaurant
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

  # def choose_collection
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   @collections = current_user.collections
  # end

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

  def delete
  end

private

  def saved_restaurant_params
    params.require(:saved_restaurant).permit(photos: [])
  end
end
