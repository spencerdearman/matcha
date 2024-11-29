class HomeController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)  # Fetch all posts, ordered by most recent
    render({ :template => "home/index" })  # Render the index template with posts
  end
end
