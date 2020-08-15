class ItemsController < ApplicationController
  def index
  end

  def show
  end
  def new
  end

  def edit
    # @item_image = Item_Image.find(params[:id])
    @item = Item.find(params[:id])
  end
  
  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      # flash[:notice] = "内容を更新しました"
      redirect_to root_path
    else
      # flash.now[:alert] = "編集内容を確認してください"
      render item_path
    end
  end
  def step1
  end

  def step2
  end

  def step3
  end

  def step4
  end

  private
  def item_params
    params.require(:item).permit(:name, :detail, :price, :brand_id, :condition_id, :fee_burden_id, :prefecture_id, :shippng_days)
  end
end
# :size_id,, :shipping_method, :category_id, :order_status, :seller, :buyer