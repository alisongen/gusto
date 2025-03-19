class CollectionsController < ApplicationController
  def index
    @user = current_user
    @collections = @user.collections
    @friendships = @user.friendships

    if params[:name].present?
      @collection_name = params[:name]
      @restaurants = Collection.find_by(user: current_user, name: params[:name]).restaurants.distinct
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

    # raise

    @collections = @user.collections
    if params[:name]
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def show
    @collection = Collection.find(params[:id])
  end

  def new
    @collection = Collection.new
    set_colors_and_emojis
  end

  def create
    @user = current_user
    @collection = Collection.new(collection_params)
    @collection.user_id = @user.id
    if @collection.save
      redirect_to dashboard_path
    else
      set_colors_and_emojis
      set_collections
      @show_modal = true
      render 'pages/dashboard', status: :unprocessable_entity
    end
  end

  def edit
    # TO DO
  end

  def update
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

  def set_colors_and_emojis
    @colors = [
      "#4B3B47", "#FFBD33", "#FFD133", "#A3E635", "#33FF57",
      "#33FFBD", "#33D1FF", "#3357FF", "#8A33FF", "#FF33F0",
      "#FF3380", "#FF3366"
    ]
    @emojis = [ "🍔", "🥞", "🧁", "🍣", "☕️", "🥗", "🍻", "🥩", "🌯", "💙", "🎉", "🍽️" ]
  end

  def set_collections
    @collections = @user.collections
  end
end
