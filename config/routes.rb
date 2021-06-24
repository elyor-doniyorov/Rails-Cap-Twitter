Rails.application.routes.draw do
  root 'opinions#index'
  devise_for :users
  resources :users, only: [:show, :index] do
    member do
      get '/follow_user/:id', to: 'users#follow_user', as: :follow
    end
  end
      resources :followings do
member do
        get '/destroy_user/:id', to: 'followings#destroy_user', as: :destroy
end
end

  resources :opinions, only: [:index, :create, :new, :destroy] do
    resources :likes, only: [:create, :destroy]
  end

end