Rails.application.routes.draw do
  devise_for :users
  # get "signup", to: "signup#index"
  resources :signup do
    collection do
      get "step1"# ユーザー登録
      get "step2"# 電話番号登録
      get "step3"# user session持ちな profiel作成
      get "step4" # 登録確認
      get "done" # 登録完了後のページ
    end
  end
  root 'items#index'

  resources :items do
    collection do
      get 'done'
    end
  end
 
end
