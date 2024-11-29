class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @posts = @user.posts.order(created_at: :desc)  # Get the posts for this user, ordered by most recent
  end
end
