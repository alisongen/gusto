class CollectionsController < ApplicationController
  def index
    @user = current_user
    @collections = @user.collections
    @friendships = @user.friendships

    if params[:name].present?
      @restaurants = Collection.find_by(user: current_user, name: params[:name]).restaurants
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
    @collection = Collection.new
  end

  def create
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
