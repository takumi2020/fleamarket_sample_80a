Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'creditcards', to: 'users/registrations#new_creditcard'
    post 'creditcards', to: 'users/registrations#create_creditcard'
  end
  resources :users, only: [:edit, :update]

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
