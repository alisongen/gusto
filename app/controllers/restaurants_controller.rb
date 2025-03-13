class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    photos = ['nick-karvounis-Ciqxn7FE4vE-unsplash_xitvdh', 'jason-leung-poI7DelFiVA-unsplash_elpnbh', 'volkan-vardar-1H30uRC1plc-unsplash_wksntl', 'jay-wennington-N_Y88TWmGwA-unsplash_rtdbef']
    @photo = photos.sample
    

    # @collections = Collection.where(user: current_user)
    # @collection = Collection.new
    # @collection.saved_restaurant = @restaurant
  end
end
