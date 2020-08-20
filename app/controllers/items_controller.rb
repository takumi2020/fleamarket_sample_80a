class ItemsController < ApplicationController
  require 'payjp'
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, only: [:show, :destroy]
  before_action :set_caegory_for_new_create, only: [:new, :create]

  def index
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
    @grandchildren = @item.category
    @children = @grandchildren.parent
  end

  def new
    @item = Item.new
    @item.item_images.build
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
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

  def set_caegory_for_new_create
    @category_parent_array = ["選択してください"] + Category.where(ancestry: nil).first(13).pluck(:name)
  end


  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def done
    @user = User.find(params[:id])
    @item = Item.find(params[:id])
    @address = Address.find(params[:id])
    @grandchildren = @item.category
    @children = @grandchildren.parent
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      # redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: '削除しました'
    else
      render :show
    end
  end

  def purchase
    @item = Item.find(params[:id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.where(user_id: current_user.id).first
    charge = Payjp::Charge.create(
      # @item.price
      amount: @item.price,
      customer: Payjp::Customer.retrieve(card.customer_id),
      currency: 'jpy'
    )
    @item_buyer = Item.find(params[:id])
    @item_buyer.update( buyer: current_user.id, order_status: "売切れ")
    redirect_to root_path, alert: '購入致しました'
  end


  private
  def item_params
    params.require(:item).permit(
      :name, :detail, :price, :category_id, :size_id, :shipping_method_id, :condition_id, :shipping_days_id, :fee_burden_id, :prefecture_id, [item_images_attributes: [:url]]
      ).merge(user_id: current_user.id, seller: current_user.id, order_status: "出品中")
  end

  def set_item
    @item = Item.find(params[:id])
  end
  
end
