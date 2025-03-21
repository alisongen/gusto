class CollectionsController < ApplicationController
  def index
    @friends_restaurants = current_user.friends_restaurants
    @collections = current_user.collections
    collection_name = params[:name]

    if collection_name
      @restaurants = Collection.find_by(user: current_user, name: collection_name).restaurants
    elsif params[:friends]
      @restaurants = @friends_restaurants
    else
      @restaurants = current_user.restaurants.distinct
    end

    @markers = @restaurants.geocoded.map do |restaurant|
      # si on filtre nos restaurants par collection
      if collection_name
        # collection = restaurant.saved_restaurants.find_by(user: current_user).collections.first
        collection = @collections.find_by(name: collection_name)
      # si on filtre en affichant les restaurants de nos friends
      elsif params[:friends]
        # friends_ids = current_user.friends.pluck(:id)
        friends = current_user.friends
        collection = SavedRestaurant.where(user: friends, restaurant: restaurant).first.collections.first
      # si on affiche tous nos restaurants
      else
        collection = restaurant.saved_restaurants.find_by(user: current_user).collections.first
      end

      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { restaurant: restaurant, collection: collection }),
        marker_html: render_to_string(partial: "marker", locals: { restaurant: restaurant, collection: collection })
      }
    end

    respond_to do |format|
      format.html
      format.turbo_stream if params[:name] || params[:friends]
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
    if @collection.save
      redirect_to dashboard_path
    else
      set_collections
      @show_modal = true
      render 'pages/dashboard', status: :unprocessable_entity
    end
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

  def set_collections
    @collections = @user.collections
  end
end
