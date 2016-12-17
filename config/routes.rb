Rails.application.routes.draw do

  root "users#new"
  delete 'logout'            => 'sessions#destroy'
  post   'login'             => 'sessions#create'
  delete 'unfriend/:user_id' => 'friendings#destroy', as: 'unfriend'

  concern :likable do
    resources :likes,    only: [:destroy, :create]
  end

  concern :commentable do
    resources :comments, only: [:create, :destroy]
  end

  resources :users do
    # resources :comments, shallow: true
    resources :posts,      shallow:  true
    resource  :profile,    except:   [:new, :create, :destroy]
    resources :photos,     only:     [:new, :create, :destroy, :index, :show]
    get       'timeline'    =>       'posts#timeline'
    get       'friends'     =>       'friendings#index'
  end

  resources :friendings,   only:     [:create]
  resources :comments,     concerns: [:likable], only: [:create, :destroy]
  resources :posts,        concerns: [:likable, :commentable], only: []
  resources :photos,       concerns: [:likable, :commentable], only: [] do

    post      'profile_pic' =>       'profile_photos#create'
    delete    'profile_pic' =>       'profile_photos#destroy'
    post      'cover_image' =>       'cover_photos#create'
    delete    'cover_image' =>       'cover_photos#destroy'
  end
  resources :likables,     concerns: [:likable], only: []
  resources :commentables, concerns: [:commentable], only: []

  # get ':posts/:post_id/like'


  # KIT SAYS DO THIS 
  # resources :posts,      concerns: [:likable, :commentable], defaults: {type: 'Post'}, only: []
  # TODO defaults
end