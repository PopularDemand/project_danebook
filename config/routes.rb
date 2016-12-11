Rails.application.routes.draw do

  root "users#new"
  delete 'logout' => 'sessions#destroy'
  post   'login' => 'sessions#create'

  concern :likable do
    resources :likes, only: [:destroy, :create]
  end

  concern :commentable do
    resources :comments, except: [:index, :show]
  end

  resources :users do
    # resources :comments, shallow: true
    resources :posts,    shallow: true
    resource  :profile,  except: [:new, :create, :destroy]
    get       'timeline' => 'posts#timeline'
  end

  # resources :comments, concerns: [:likable]
  resources :posts,    concerns: [:likable, :commentable], only: []

  # get ':posts/:post_id/like'

end