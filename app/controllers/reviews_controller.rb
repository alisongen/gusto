class ReviewsController < ApplicationController

  def restaurant_index
    # @restaurant = Restaurant.find(params.......)
    @restaurant.review.all
  end

  def delete

  end

  def create
    # @restaurant = Restaurant.find(params[:restaurant_id])
    @saved_restaurant = SavedRestaurant.find(params[:saved_restaurant_id])
    @review = Review.new(review_params)
    @review.user = current_user
    # @review.saved_restaurant = SavedRestaurant.where(restaurant_id: params[:restaurant_id], user_id: current_user.id).first
    @review.saved_restaurant = @saved_restaurant
    if @review.save
      # redirect_to restaurant_path(@restaurant)
      redirect_to restaurant_path(@saved_restaurant.restaurant)
    else
      flash[:alert] = "Something went wrong."
      render "restaurants/show", status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to restaurant_path()
  end

  private

  def review_params
    params.require(:review).permit(:content, :user_rating)
  end
end
