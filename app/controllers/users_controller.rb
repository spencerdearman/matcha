class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followed_users  # Reverse logic, now followers are those followed by @user
  end

  def following
    @user = User.find(params[:id])
    @following = @user.followers  # Reverse logic, now following are those who follow @user
  end
end
