class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
  
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private 

  def record_not_found_response
    render json: {error: "user not found"}, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price)
  end


end
