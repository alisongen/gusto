class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :destroy, :accept, :decline]

  def index
    @friendships = Friendship.all
  end

  def show
     # J'assigne à ma variable d'instance "@user" le "current_user"
     @user = User.find(@friendship.user_id)
     # Récupération de tout les saved_restaurants de mon @user
     @saved_restaurants = @user.saved_restaurants
     # Récupération des collections de mon @user
     @collections = @user.collections
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new
    @friendship.user_id = current_user.id
    @friendship.friend_id = User.find(params[:format].to_i).id
    @friendship.save
    @friendship.pending!
    redirect_to friendships_path()
  end

  def destroy
    @friendship.destroy
    redirect_to friendships_path()
  end

  def accept
    @friendship.accepted!
    redirect_to friendships_path()
  end

  def decline
    @friendship.decline!
    @friendship.destroy
    redirect_to friendships_path()
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end
end
