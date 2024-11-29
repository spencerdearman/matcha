class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    like = Like.new(user: current_user, post: @post)

    if like.save
      respond_to do |format|
        format.turbo_stream # Turbo Stream Response
        format.html { redirect_to root_path(anchor: "post-#{@post.id}") } # Anchor fallback
      end
    else
      redirect_to root_path, alert: "Failed to like post."
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by(user: current_user)

    if like.destroy
      respond_to do |format|
        format.turbo_stream # Turbo Stream Response
        format.html { redirect_to root_path(anchor: "post-#{@post.id}") } # Anchor fallback
      end
    else
      redirect_to root_path, alert: "Failed to unlike post."
    end
  end
end
