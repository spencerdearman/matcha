class CafesController < ApplicationController
  def index
    matching_cafes = Cafe.all

    @list_of_cafes = matching_cafes.order({ :created_at => :desc })

    render({ :template => "cafes/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_cafes = Cafe.where({ :id => the_id })

    @the_cafe = matching_cafes.at(0)

    render({ :template => "cafes/show" })
  end

  def create
    the_cafe = Cafe.new
    the_cafe.user_id = params.fetch("query_user_id")
    the_cafe.name = params.fetch("query_name")
    the_cafe.address = params.fetch("query_address")
    the_cafe.lat = params.fetch("query_lat")
    the_cafe.lng = params.fetch("query_lng")
    the_cafe.description = params.fetch("query_description")

    if the_cafe.valid?
      the_cafe.save
      redirect_to("/cafes", { :notice => "Cafe created successfully." })
    else
      redirect_to("/cafes", { :alert => the_cafe.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_cafe = Cafe.where({ :id => the_id }).at(0)

    the_cafe.user_id = params.fetch("query_user_id")
    the_cafe.name = params.fetch("query_name")
    the_cafe.address = params.fetch("query_address")
    the_cafe.lat = params.fetch("query_lat")
    the_cafe.lng = params.fetch("query_lng")
    the_cafe.description = params.fetch("query_description")

    if the_cafe.valid?
      the_cafe.save
      redirect_to("/cafes/#{the_cafe.id}", { :notice => "Cafe updated successfully."} )
    else
      redirect_to("/cafes/#{the_cafe.id}", { :alert => the_cafe.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_cafe = Cafe.where({ :id => the_id }).at(0)

    the_cafe.destroy

    redirect_to("/cafes", { :notice => "Cafe deleted successfully."} )
  end
end
