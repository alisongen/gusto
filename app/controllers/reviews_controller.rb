class ReviewsController < ApplicationController
  def new
    
  end

  def create

  end

  def restaurant_index
    # @restaurant = Restaurant.find(params.......)
    @restaurant.review.all
  end

  def delete

  end
end
