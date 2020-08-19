class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit,:profile,:profile_update,:logout]
  before_action :set_address, only: [:edit, :update]

  def show
  end

  def edit
  end

  def logout
  end

  def update
    if @address.update(address_params)
      redirect_to edit_user_path(@address)
    else
      render :edit
    end
  end


  def address
    @address = Address.find(params[:id])
  end

  def address_update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "内容を更新しました"   
      redirect_to address_user_path
    else
      flash.now[:alert] = "編集内容を確認してください"
      render :profile
    end
  end

  def profile
    @user = User.find(params[:id])
  end

  def profile_update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "内容を更新しました"   
      redirect_to profile_user_path
    else
      flash.now[:alert] = "編集内容を確認してください"
      render :profile
    end
  end

  def credit_save
  end
  

  
  private
  def address_params
    params.require(:address).permit(:postal_code, :prefecture, :city, :house_number, :building_name, :tell)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_address
    @address = Address.find(params[:id])
  end

  def set_category
    @parents = Category.all.order("id ASC").limit(13)
  end
  def user_params
    params.require(:user).permit(:nickname, :introduce, :user_img)
  end
end