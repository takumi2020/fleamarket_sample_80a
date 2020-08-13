class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create, :create_address, :create_creditcard]
  # before_action :configure_account_update_params, only: [:update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
      render :new_address
    end
    session["devise.regist_data"] = {user: @user.attributes}
    # この記述でもOKです。session["devise.regist_data"] [user]= @user.attributes
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end


  def new_address
    # @user = User.new(session["devise.regist_data"]["user"])
    # @address = Address.new(address_params)
    # # # unless @address.valid?
    # #   flash.now[:alert] = @address.errors.full_messages
    # #   render :new_address and return
    # # end
    # @user.addresses.build(@address.attributes)
    # @user.save
    # sign_in(:user, @user)
    # redirect_to root_path
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    session["address"] = @address.attributes
    @creditcard = @user.build_creditcard
    render :new_creditcard
  end


  def new_creditcard
  end
  

  def create_creditcard
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(session["address"])
    @creditcard = Creditcard.new(creditcard_params)
    unless @creditcard.valid?
      flash.now[:alert] = @creditcard.errors.full_messages
      render :new_credit_card and return
    end
    @user.build_address(@address.attributes)
    @user.build_creditcard(@creditcard.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end

  def edit_address
    @address = Address.find(params[:id])
  end

  def update_address
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to purchase_index_path
  end

  

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  def address_params
    params.require(:address).permit(:postal_code, :prefecture, :city, :house_number, :building_name)
  end

  def creditcard_params
    params.require(:creditcard).permit(:card_company, :card_number, :card_year, :card_month, :card_pass)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
