class SavedRestaurantCollectionsController < ApplicationController
  def edit
  end

  def update
    @collection = Collection.find(params[:id])
    @collection.update(params[:collection])
  end
end
