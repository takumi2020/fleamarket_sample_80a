Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:edit, :update]
  # get "signup", to: "signup#index"
  # resources :signup do
  #   collection do
  #     get "step1"# ユーザー登録
  #     get "step2"# 電話番号登録
  #     get "step3"# user session持ちな profiel作成
  #     get "step4" # 登録確認
  #     get "done" # 登録完了後のページ
  #   end
  # end
  root 'items#index'
  resources :items do
    collection do
      get "new_user"
      get "new_telephone"
      get "new_address"
      get "user_done"
      get "signup_new"
      get "signup_done"
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
