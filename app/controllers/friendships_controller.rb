class FriendshipsController < ApplicationController

  def index
    @friendships = Friendship.all
  end

  def show
    @friendship = Friendship.find(params[:id])
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new
    @friendship.user_id = current_user.id
    @friendship.friend_id = User.find(params[:user_id])
  end

  def delete

  end
end
