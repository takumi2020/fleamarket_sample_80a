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
    @item = Item.new(item_params1)
    if @item.save
      redirect_to root_path
    else
      redirect_to new_item_path
    end
  end
  

  def set_parents
    @parents = Category.where(ancestry: nil)
  end



  def edit
    # @item_image = Item_Image.find(params[:id])
    @item = Item.find(params[:id])
  end
  
  def update
    item = Item.find(params[:id])
    if item.update(item_params2)
      # flash[:notice] = "内容を更新しました"
      redirect_to root_path
    else
      # flash.now[:alert] = "編集内容を確認してください"
      @images = @item.item_images
      render :edit
    end
    # @item.update(item_params2)
  end

  def step1
  end


  def set_parents
    @parents = Category.where(ancestry: nil)
  end
  private
  def item_params1
    params.require(:item).permit(
      :name, :detail, :price, :condition_id, :shipping_days_id, :fee_burden_id, :prefecture_id, [brand_attributes: [:name]], [item_images_attributes: [:url]]
      )
  end


  private
  def item_params2
    params.require(:item).permit(:name, :detail, :price, :brand_id, :condition_id, :fee_burden_id, :prefecture_id, :budget_d, :shipping_days_id, item_images_attributes: [:url, :_destroy, :id])
  end

  # def item_update_params
  #   params.require(:item).permit(
  #     :name,
  #     [item_images: [:url, :_destroy, :id]])
  # end
end
# :size_id,, :shipping_method, :category_id, :order_status, :seller, :buyer