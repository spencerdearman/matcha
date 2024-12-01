class ExploreController < ApplicationController
  before_action :authenticate_user!
  
  def index
    render({ :template => "explore/index" })
  end
end
