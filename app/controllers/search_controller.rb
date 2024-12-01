class SearchController < ApplicationController
  before_action :authenticate_user!
  
  def index
    render({ :template => "search/index" })
  end
end
