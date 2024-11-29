class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    # The current_user is the follower
    followed_user = User.find(params[:followed_id])

    # Create a new follow relationship
    follow = current_user.followed_relationships.new(followed: followed_user)

    if follow.save
      redirect_to user_path(followed_user), notice: 'You are now following this user.'
    else
      redirect_to user_path(followed_user), alert: 'Something went wrong.'
    end
  end

  def destroy
    followed_user = User.find(params[:followed_id])

    # Find the follow record for the current_user and the followed_user
    follow = current_user.followed_relationships.find_by(followed: followed_user)

    if follow
      follow.destroy
      redirect_to user_path(followed_user), notice: 'You have unfollowed this user.'
    else
      redirect_to user_path(followed_user), alert: 'Something went wrong.'
    end
  end
end
