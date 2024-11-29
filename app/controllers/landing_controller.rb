class LandingController < ApplicationController
  def index
    # Ensure we are fetching posts for the feed
    @posts = Post.all.order(created_at: :desc)  # You can adjust the query to suit your needs
  end
end
