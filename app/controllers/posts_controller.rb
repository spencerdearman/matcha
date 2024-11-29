class PostsController < ApplicationController
  before_action :authenticate_user! # Ensures user is logged in
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # List all posts in descending order of creation
  def index
    @list_of_posts = Post.all.order(created_at: :desc)
  end

  # Show a single post along with its associated comments and likes
  def show
    @comments = @post.comments.includes(:user) # Preload users to avoid N+1 queries
    @like = @post.likes.find_by(user: current_user) # Fetch the current user's like if it exists
    @the_post = Post.find(params[:id])
  
    respond_to do |format|
      format.html # Default behavior: renders the `show.html.erb` view
      format.json do
        render json: {
          id: @the_post.id,
          image_url: url_for(@the_post.image),
          caption: @the_post.caption,
          user: { id: @the_post.user.id, username: @the_post.user.username },
          comments: @the_post.comments.map do |comment|
            {
              content: comment.content,
              user: { id: comment.user.id, username: comment.user.username }
            }
          end
        }
      end
    end
  end

  # Initialize a new post
  def new
    @post = current_user.posts.new
  end

  # Create a new post and associate it with the current user
  def create
    @post = current_user.posts.new(post_params)
  
    if @post.save
      redirect_to root_path, notice: "Post created successfully." # Redirect to the home page
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  # Edit an existing post
  def edit
    # The @post is already set by the `set_post` callback
  end

  # Update an existing post
  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post updated successfully."
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :edit
    end
  end

  # Delete an existing post
  def destroy
    if @post.destroy
      redirect_to posts_path, notice: "Post deleted successfully."
    else
      redirect_to posts_path, alert: "Unable to delete post."
    end
  end

  private

  # Strong parameters to permit only specific attributes
  def post_params
    params.require(:post).permit(:caption, :image)
  end

  # DRY principle: Set the @post instance variable for actions that require it
  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: "Post not found."
  end
end
