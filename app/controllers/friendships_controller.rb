class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :destroy, :accept, :decline]

  def index
    @friendships = Friendship.all
  end

  def show
  
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new
    @friendship.user_id = current_user.id
    @friendship.friend_id = User.find(params[:user_id])
    @friendship.save
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
    redirect_to friendship_path()
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end
end
