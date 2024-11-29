class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])  # Find the user by their ID
  end
end
