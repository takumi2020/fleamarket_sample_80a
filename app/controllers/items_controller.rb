class ItemsController < ApplicationController

  def index
  end

  def show
    @item = Item.find(params[:id])
    # @item_image = ItemImage.find(params[:id])
  end

  def new
    @item = Item.new
    @item.item_images.build
    @item.build_brand
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      redirect_to new_item_path
    end
  end

def search_child
  respond_to do |format|
    format.html
    format.json do
      @childrens = Category.find(params[:parent_id]).children
    end
  end
end

def search_grandchild
  respond_to do |format|
    format.html
    format.json do
      @grandchildrens = Category.find(params[:child_id]).children
    end
  end
end

  private
  def item_params
    params.require(:item).permit(
      :name, :detail, :price, :category_id, :size_id, :shipping_method_id, :condition_id, :shipping_days_id, :fee_burden_id, :prefecture_id, [brand_attributes: [:name]], [item_images_attributes: [:url]]
      )
  end
  
end
