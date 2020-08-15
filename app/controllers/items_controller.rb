class ItemsController < ApplicationController
  def index
  end

  def show
    @item = Item.find(params[:id])
    @item_image = ItemImage.find(params[:id])
  end

  def new
  end

  def done
  end
  
end
