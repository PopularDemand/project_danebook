Rails.application.routes.draw do
  delete 'logout' => 'sessions#destroy'
  post 'login' => 'sessions#create'

  concern :likable do
    resources :likes, only: [:destroy, :create]
  end

  root "users#new"
  resources :users do
    resources :posts, shallow: true
    resource :profile, except: [:new, :create, :destroy]
    get 'timeline' => 'posts#timeline'
  end

  resources :posts, concerns: [:likable]

  # get ':posts/:post_id/like'

end