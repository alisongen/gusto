require "open-uri"

class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  # GET /ezhfuhef/:restaurant_id
  def set_restaurant
    # call api en utilisant l'restaurant_id pour récupérer les informations du restaurant
    # Avec ces informations je fabrique mon instance SI elle n'existe pas deja
    # restaurant = Restaurant.find_or_create(datas de la reponse api)
    # je redirect_to vers la restaurant_path(restaurant)
  end

  def show
    @user = current_user
    # trouver les relations entre nous et qqun d'autre qui ont le statut accepté
    @friends = current_user.friends

    if Restaurant.find_by(id: params[:id])
      @restaurant = Restaurant.find(params[:id])
    else
      restaurant_data = GetGooglePlaceDetailsService.new(params[:id]).call
      restaurant_params = { name: restaurant_data.dig("displayName", "text"), address: restaurant_data.dig("formattedAddress"), category: restaurant_data.dig("primaryTypeDisplayName", "text"), rating: restaurant_data.dig("rating"), phone_number: restaurant_data.dig("nationalPhoneNumber"), website: restaurant_data.dig("websiteUri") }
      @restaurant = Restaurant.find_by(restaurant_params)

      if @restaurant.nil?
        @restaurant = Restaurant.create(restaurant_params)
        @photos = restaurant_data["photos"].map do |photo_data|
          img_uri = GetGooglePhotosDataService.new(photo_data["name"]).call
          photo_file = URI.parse(img_uri).open
          @restaurant.images.attach(io: photo_file, filename: "#{img_uri}.png", content_type: "image/png")
          @restaurant.save
        end
      end

      respond_to do |format|
        format.html # Rendu pour une page HTML
        format.json { render json: @restaurants } # Permet aussi d'utiliser en API
      end
    end

    @images = @restaurant.images
    # @image = @images.sample
    @collections = Collection.where(user_id: current_user.id)
    @saved_restaurant = SavedRestaurant.find_by(restaurant: @restaurant, user: current_user)
    @saved_restaurants = SavedRestaurant.where(user: current_user)
    @review = Review.new
    @reviews = Review.all
  end

  def update_collection
    @restaurant = Restaurant.find(params[:restaurant_id])
    @saved_restaurant = SavedRestaurant.find_or_create_by(restaurant: @restaurant, user: current_user)
    @collections = Collection.where(user: current_user)

    if params[:collection_ids]
      params[:collection_ids].each do |collec_id|
        SavedRestaurantsCollection.create(collection: Collection.find(collec_id), saved_restaurant: @saved_restaurant)
      end
    else
      @saved_restaurant.destroy
    end

    @saved_restaurant.saved_restaurants_collections.where.not(collection_id: params[:collection_ids]).destroy_all

    redirect_to collections_path, format: :html
  end

  def destroy
    @saved_restaurant = SavedRestaurant.find(params[:format])
    @photo = @saved_restaurant.photos.find(params[:id])
    @photo.destroy
    redirect_to restaurant_path(@saved_restaurant.restaurant_id)
  end
end
