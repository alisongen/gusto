class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @user = current_user
    @saved_restaurant = current_user.saved_restaurants.first
    # @collection.user = @user
    # @collection = Collection.find(name: "Favorites")
  end
end
