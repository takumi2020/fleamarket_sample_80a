Rails.application.routes.draw do
  root 'items#index'
  resources :items do
    collection do
      get "step1"
      get "step2"
      get "step3"
      get "step4"
      get "signup1"
      get "signup2"
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
