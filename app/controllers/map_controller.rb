class MapController < ApplicationController
  before_action :authenticate_user!
  
  def index
    render({ :template => "map/index" })
  end
end
