class UsersController < ApplicationController
  
  def show
    user = User.find(params[:id])
    if user
      render json: user, include: :items
    else
      render json: {error: "User not found"}, status: 404
    end
  end

end
