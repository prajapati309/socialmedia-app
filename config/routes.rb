Rails.application.routes.draw do
  resources :controllers
  mount ActionCable.server, at: '/cable'  
  resources :chatrooms do 
    resource :chatroom_users
    resources :chatroom_messages

  end
  get 'pages/_profile'

  put 'deactivate/:id(.:format)', :to => 'users#deactivate', :as => :deactivate_user
  put 'activate/:id(.:format)', :to => 'users#activate', :as => :activate_user
  get 'ckeditor/pictures'
  get '/friends', to: 'friendships#index', as: 'friends'
  get '/news', to: 'news#index', as: 'news'
  get '/newsfeed' , to: 'news#index', as: 'newsfeed'
  root 'conversations#index'  
  get '/posts', to: 'posts#index', as: 'posts'
post 'friends/create/:id', to: 'friendships#create', as: 'add_friend'
put 'friends/accept.:id', to: 'friendships#accept', as: 'accept_request'
delete 'friends/deny/:id', to: 'friendships#deny', as: 'deny_request'
delete 'friends/delete/:id', to: 'friendships#destroy', as: 'delete_friend'

  resources :friendships
  resources :posts do
    resources :comments 
  	resources :likes 
  end
  resources :comments do
  	resources :comments 
  end
  resources :rooms do
    get 'join', :on => :member
    delete 'leave', :on => :member    
  end
  
  resources :memberships, except: [:new]

  resources :events 
  get 'pages/home'
  devise_for :users
  resources :users, only: [:index , :destroy , :show]
  resources :messages, only: [:create , :new]
  resources :conversations, only: [:index, :show , :new]
    
  resources :room_messages
  resources :rooms , except: [:show]
  resources :rooms, only: [:show], shallow: true do
   resources :memberships, only: [:new] #-> domain.com/2/memberships/new
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
