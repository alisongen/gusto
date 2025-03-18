class ReviewsController < ApplicationController

  def restaurant_index
    # @restaurant = Restaurant.find(params.......)
    @restaurant.review.all
  end

  def delete

  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.saved_restaurant_id = SavedRestaurant.where(restaurant_id: params[:restaurant_id], user_id: current_user.id).first.id
    if @review.save
      redirect_to restaurant_path(@restaurant)
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
