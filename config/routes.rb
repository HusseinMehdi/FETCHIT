Rails.application.routes.draw do
  # Root path
  root 'sessions#new'
  
  # Session routes
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  # User routes
  resources :users, only: [:new, :create, :edit, :update, :index, :destroy] 

  # Report routes
  resources :reports, only: [:new] do
    collection do
      get 'results', to: 'reports#show'
      get 'export', defaults: { format: 'xlsx' }
    end
  end  
end
