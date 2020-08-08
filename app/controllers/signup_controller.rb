class SignupController < ApplicationController

def step1
  @user = User.new
end

def step2
  session[:nickname] = user_params[:nickname]
  session[:email] = user_params[:email]
  session[:password] = user_params[:password]
  session[:password_confirmation] = user_params[:password_confirmation]
  @user = User.new
end

def step3
  session[:family_name] = user_params[:family_name]
  session[:first_name] = user_params[:first_name]
  session[:family_name_kana] = user_params[:family_name_kana]
  session[:first_name_kana] = user_params[:first_name_kana]
  @user = User.new
end

def create
  @user = User.new(
    nickname: session[:nickname],
    email: session[:email],
    password: session[:password],
    password_confirmation: session[:password_confirmation],
    family_name: session[:family_name],
    first_name: session[:first_name],
    family_name_kana: session[:family_name_kana],
    first_name_kana: session[:first_name_kana],
    #アドレスも追加していく

  )
  if @user.save
    session[:id] = @user.id
    redirect_to #リダイレクト先
  else
    render #レンダー先
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
    :first_name,
    :family_name_kana,
    :birthday,
    :tell,
    :introduction,
    :user_img
  )
end

end
