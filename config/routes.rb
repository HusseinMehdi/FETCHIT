Rails.application.routes.draw do
  
  #localhost:3000
  root 'sessions#new'
  
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  get 'report', to: 'sessions#report', as: 'report'

  resources :users, only: [:new, :create, :edit, :update, :index, :destroy] 



end
