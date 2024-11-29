class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @list_of_posts = Post.all.order(created_at: :desc)
  end

  def show
    # The @the_post is already set by the `set_post` callback
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
  
    if @post.save
      redirect_to posts_path, notice: "Post created successfully."
    else
      render :new, alert: @post.errors.full_messages.to_sentence
    end
  end  

  def edit
    # The @post is already set by the `set_post` callback
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post updated successfully."
    else
      render :edit, alert: @post.errors.full_messages.to_sentence
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully."
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
