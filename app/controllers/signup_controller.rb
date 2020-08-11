class SignupController < ApplicationController

  def index
    
  end
  
  def step1
    @user = User.new
  end
  
  def step2
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:family_name] = user_params[:family_name]
    session[:last_name] = user_params[:last_name]
    session[:family_name_kana] = user_params[:family_name_kana]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:birth_date] = user_params[:birth_date]
    @user = User.new
  end
  
  def step3
    session[:tell] = user_params[:tell]
    @user = User.new
  end

  def step4
    @user = User.new
    session[:postal_code] = user_params[:postal_code]
    session[:prefecture] = user_params[:prefecture]
    session[:city] = user_params[:city]
    session[:house_number] = user_params[:house_number]
    session[:building_name] = user_params[:building_name]
  end
  
  
  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      family_name: session[:family_name],
      last_name: session[:last_name],
      family_name_kana: session[:family_name_kana],
      last_name_kana: session[:last_name_kana],
      birth_date: session[:birth_date], 
      tell: session[:tell],
      postal_code: session[:postal_code],
      prefecture: session[:prefecture],
      city: session[:city],
      house_number: session[:house_number],
      building_name: session[:building_name]
    )
    if @user.save
      session[:id] = @user.id
      redirect_to done_signup_index_path
    else
      render '#'
      # '/signup/registration'
    end
  end
  
  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :password_confirmation,
      :family_name,
      :last_name,
      :family_name_kana,
      :last_name_kana,
      :birth_date,
      :tell,
      :introduction,
      # :user_img,
      :postal_code,
      :prefecture,
      :city,
      :house_number,
      :building_name
    )
  end
  
end
