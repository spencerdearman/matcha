class FollowsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    matching_follows = Follow.all

    @list_of_follows = matching_follows.order({ :created_at => :desc })

    render({ :template => "follows/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_follows = Follow.where({ :id => the_id })

    @the_follow = matching_follows.at(0)

    render({ :template => "follows/show" })
  end

  def create
    the_follow = Follow.new
    the_follow.follower_id = params.fetch("query_follower_id")
    the_follow.followed_id = params.fetch("query_followed_id")

    if the_follow.valid?
      the_follow.save
      redirect_to("/follows", { :notice => "Follow created successfully." })
    else
      redirect_to("/follows", { :alert => the_follow.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_follow = Follow.where({ :id => the_id }).at(0)

    the_follow.follower_id = params.fetch("query_follower_id")
    the_follow.followed_id = params.fetch("query_followed_id")

    if the_follow.valid?
      the_follow.save
      redirect_to("/follows/#{the_follow.id}", { :notice => "Follow updated successfully."} )
    else
      redirect_to("/follows/#{the_follow.id}", { :alert => the_follow.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_follow = Follow.where({ :id => the_id }).at(0)

    the_follow.destroy

    redirect_to("/follows", { :notice => "Follow deleted successfully."} )
  end
end
