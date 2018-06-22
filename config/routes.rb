Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  
  get 'user_details/:id' => 'user_details#show', as: 'user_detail'
  #resources :user_details, only: [:show]
end
