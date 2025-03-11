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

  end

  def delete

  end

  private

  def friendship_params
    params.require(:booking).permit(:reservation_date, :user_id, :dream_id)
  end
end
