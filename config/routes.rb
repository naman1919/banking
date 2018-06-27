Rails.application.routes.draw do

  root 'welcome#index'
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'welcome/index'
  # get 'user_details/:id' => 'user_details#show', as: 'user_detail'
  resources :welcome, only: [:index, :show]
  
  resources :beneficiaries

  resources :transactions, only: [:index, :new, :create] do
    get 'generate_otp',on: :member
  end

  resources :users, only: [:create] do
    get 'verify',on: :member
  end
end
