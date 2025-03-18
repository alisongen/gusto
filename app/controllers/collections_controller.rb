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
  end

  def show
    @collection = Collection.find(params[:id])
  end

  def new
    @collection = Collection.new
    @colors = [
      "#4B3B47", # Eggplant
      "#FFBD33", # Orange
      "#FFD133", # Yellow
      "#A3E635", # Lime Green
      "#33FF57", # Green
      "#33FFBD", # Mint
      "#33D1FF", # Sky Blue
      "#3357FF", # Blue
      "#8A33FF", # Purple
      "#FF33F0", # Pink
      "#FF3380", # Hot Pink
      "#FF3366"  # Red
    ]
    @emojis = [ "🍔", "🥞", "🧁", "🍣", "☕️", "🥗", "🍻", "🥩", "🌯", "💙", "🎉", "🍽️" ]
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
    params.require(:collection).permit(:name, :color, :emoji)
  end
end
