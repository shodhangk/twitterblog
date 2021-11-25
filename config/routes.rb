Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions },
                       path_names: { sign_in: :login }
  end

  resources :posts, only: %i[index create show] do
    member do
      post 'like'
    end
  end

  resources :comments, only: [:create] do
    member do
      post 'like'
    end
  end

  post '/users/:id/follow', to: 'users#follow', as: 'follow_user'
  post '/users/:id/unfollow', to: 'users#unfollow', as: 'unfollow_user'
end
