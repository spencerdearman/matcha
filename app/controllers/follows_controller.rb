class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user_to_follow = User.find(params[:followed_id])

    # Ensure the current user is not following themselves
    if @user_to_follow != current_user
      current_user.follow(@user_to_follow)  # reversed: adds the user as a follower
      redirect_to user_path(@user_to_follow), notice: 'You are now following this user.'
    else
      redirect_to user_path(@user_to_follow), alert: 'You cannot follow yourself.'
    end
  end

  def destroy
    @user_to_unfollow = User.find(params[:followed_id])

    # Ensure the current user is not trying to unfollow themselves
    if @user_to_unfollow != current_user
      current_user.unfollow(@user_to_unfollow)  # reversed: removes the user from followers
      redirect_to user_path(@user_to_unfollow), notice: 'You have unfollowed this user.'
    else
      redirect_to user_path(@user_to_unfollow), alert: 'You cannot unfollow yourself.'
    end
  end
end
