class CollectionsController < ApplicationController
  def index
    @user = User.first
    if params[:collection_name]
      collection = @user.collections.find_by(name: params[:collection_name])
      @restaurants = collection.restaurants
    else
      @restaurants = @user.restaurants
    end
    # raise
    @markers = @restaurants.geocoded.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { restaurant: restaurant }),
        marker_html: render_to_string(partial: "marker")
      }
    end

    @collections = @user.collections
    if params[:collection_name]
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.set_dataset_attribute("#mapbox-collection", "map-markers-value", @markers)
        end
      end
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
