Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"
  
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    # 瀏覽所有餐廳的最新動態
    collection do
      get :feeds
    end

    member do
      # 瀏覽個別餐廳的 Dashboard
      get :dashboard
      # user favorite功能
      post :favorite
      post :unfavorite
      # user like功能
      post :like
      post :unlike
    end
    
  end

  resources :categories, only: :show

  resources :users, only: [:show, :edit, :update]

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
end
