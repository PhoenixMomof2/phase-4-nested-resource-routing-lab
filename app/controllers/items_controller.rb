class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found

  def index
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def create
      user = find_user
      item = user.items.create(item_params)
      render json: item, status: :created
  end

  def show
    item = find_item
    render json: item
  end

  private
  def item_params
    params.permit(:name, :description, :price)
  end

  def find_item
    Item.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end

  def render_response_not_found(exception)
    render json: { error: "#{exception.model} not found" }, status: 404
  end
end
