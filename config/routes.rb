Rails.application.routes.draw do
  get 'users/show'
  get 'profiles/show'
  get 'landing/index'

  # Devise routes for user authentication
  devise_for :users

  # For authenticated users, redirect to the landing page
  authenticated :user do
    root 'landing#index', as: :authenticated_root  # Users are redirected to the landing page
  end

  # For unauthenticated users, show the home page (or login page)
  root to: 'home#index'  # Unauthenticated users will see the home page

  # Routes for the Post resource (Standard RESTful routes)
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :users, only: [:show] do
    member do
      get :followers
      get :following
    end
  end

  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  # Routes for the Follow resource
  post '/insert_follow', to: 'follows#create', as: :create_follow  # Create a new follow
  delete '/destroy_follow/:followed_id', to: 'follows#destroy', as: :destroy_follow  # Unfollow a user

  # Profile route
  get 'profile', to: 'profiles#show', as: :profile

  # Routes for the Like resource:
  post("/insert_like", { :controller => "likes", :action => "create" })
  get("/likes", { :controller => "likes", :action => "index" })
  get("/likes/:path_id", { :controller => "likes", :action => "show" })
  post("/modify_like/:path_id", { :controller => "likes", :action => "update" })
  get("/delete_like/:path_id", { :controller => "likes", :action => "destroy" })

  # Routes for the Cafe resource:
  post("/insert_cafe", { :controller => "cafes", :action => "create" })
  get("/cafes", { :controller => "cafes", :action => "index" })
  get("/cafes/:path_id", { :controller => "cafes", :action => "show" })
  post("/modify_cafe/:path_id", { :controller => "cafes", :action => "update" })
  get("/delete_cafe/:path_id", { :controller => "cafes", :action => "destroy" })

  # Routes for the Comment resource:
  post("/insert_comment", { :controller => "comments", :action => "create" })
  get("/comments", { :controller => "comments", :action => "index" })
  get("/comments/:path_id", { :controller => "comments", :action => "show" })
  post("/modify_comment/:path_id", { :controller => "comments", :action => "update" })
  get("/delete_comment/:path_id", { :controller => "comments", :action => "destroy" })

  # Routes for the Post resource:
  post("/insert_post", { :controller => "posts", :action => "create" })
  get("/posts", { :controller => "posts", :action => "index" })
  get("/posts/:path_id", { :controller => "posts", :action => "show" })
  post("/modify_post/:path_id", { :controller => "posts", :action => "update" })
  get("/delete_post/:path_id", { :controller => "posts", :action => "destroy" })
end
