class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment added successfully!'
    else
      redirect_to post_path(@post), alert: 'Error adding comment.'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment deleted successfully!'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
