Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  get 'movies/create'
  get 'movies/destroy'
  get 'movies/edit'
  get 'movies/update'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  post 'users/update'
  get 'users/edit'
  get 'toppages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update]
  
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :liketo
      get :likefrom
    end
  end
  
  resources :movies, only: [:index, :create, :destroy, :edit, :update, :show]
  resources :favorites, only: [:create, :destroy]
end