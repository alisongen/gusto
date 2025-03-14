class CollectionsController < ApplicationController
  def index
    @user = User.first
    @collections = @user.collections

    if params[:name].present?
      @restaurants = Collection.find_by(name: params[:name]).restaurants
    else
      @restaurants = @user.restaurants
    end

    @markers = @restaurants.geocoded.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { restaurant: restaurant }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @collection = Collection.find(params[:id])
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @collection = Collection.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @user = current_user
    @collection = Collection.new(collection_params)
    @collection.user_id = @user.id
    @collection.save
    redirect_to collection_path(@collection)
  end

  def edit
    # TO DO
  end

  def update
    # TO DO
  end

  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    redirect_to collection_path()
  end

  private

  def collection_params
    params.require(:collection).permit(:name)
  end
end
