class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # J'assigne à ma variable d'instance "@restaurants" les restaurants correspondant à ma recherche
    # si une valeur "query" est présente dans mes params
    @restaurants = Restaurant.search_by_name(params[:query]) if params[:query].present?

    @user = User.find(12)
    @saved_restaurants = @user.saved_restaurants
  end
end
