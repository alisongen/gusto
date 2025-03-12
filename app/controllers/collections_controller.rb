class CollectionsController < ApplicationController
  def index
    @user = current_user
    @collections = @user.collections
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
    params.require(:collection).permit(:name)
  end
end
