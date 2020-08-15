class ItemsController < ApplicationController
  before_action :set_parents, only: [:new, :create]

  def index
  end

  def show
    @item = Item.find(params[:id])
    @item_image = ItemImage.find(params[:id])
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
  

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  private
  def item_params
    params.require(:item).permit(
      :name, :detail, :price, :condition_id, :shipping_days_id, :fee_burden_id, :prefecture_id, [brand_attributes: [:name]], [item_images_attributes: [:url]]
      )
  end
end
