class UsersController < ApplicationController
  before_action :authenticate_user!

  # Show the user's profile
  def show
    @user = User.find(params[:id])
  end

  # Display the followers of the user (flipped logic here)
  def followers
    @user = User.find(params[:id])
    @followers = @user.followed_users  # Swapping this to follow the "followed_users" association
  end

  # Display the users the current user is following (flipped logic here)
  def following
    @user = User.find(params[:id])
    @following = @user.followers  # Swapping this to follow the "followers" association
  end
end
