Rails.application.routes.draw do
  get 'landing/index'

  # Devise routes for user authentication
  devise_for :users

  # Define other routes as needed
  root to: "home#index"  # Replace with your desired root path

  # Landing page after sign-in
  authenticated :user do
    root 'landing#index', as: :authenticated_root
  end

  # Routes for the Like resource:

  # CREATE
  post("/insert_like", { :controller => "likes", :action => "create" })
          
  # READ
  get("/likes", { :controller => "likes", :action => "index" })
  
  get("/likes/:path_id", { :controller => "likes", :action => "show" })
  
  # UPDATE
  
  post("/modify_like/:path_id", { :controller => "likes", :action => "update" })
  
  # DELETE
  get("/delete_like/:path_id", { :controller => "likes", :action => "destroy" })

  #------------------------------

  # Routes for the Follow resource:

  # CREATE
  post("/insert_follow", { :controller => "follows", :action => "create" })
          
  # READ
  get("/follows", { :controller => "follows", :action => "index" })
  
  get("/follows/:path_id", { :controller => "follows", :action => "show" })
  
  # UPDATE
  
  post("/modify_follow/:path_id", { :controller => "follows", :action => "update" })
  
  # DELETE
  get("/delete_follow/:path_id", { :controller => "follows", :action => "destroy" })

  #------------------------------

  # Routes for the Cafe resource:

  # CREATE
  post("/insert_cafe", { :controller => "cafes", :action => "create" })
          
  # READ
  get("/cafes", { :controller => "cafes", :action => "index" })
  
  get("/cafes/:path_id", { :controller => "cafes", :action => "show" })
  
  # UPDATE
  
  post("/modify_cafe/:path_id", { :controller => "cafes", :action => "update" })
  
  # DELETE
  get("/delete_cafe/:path_id", { :controller => "cafes", :action => "destroy" })

  #------------------------------

  # Routes for the Comment resource:

  # CREATE
  post("/insert_comment", { :controller => "comments", :action => "create" })
          
  # READ
  get("/comments", { :controller => "comments", :action => "index" })
  
  get("/comments/:path_id", { :controller => "comments", :action => "show" })
  
  # UPDATE
  
  post("/modify_comment/:path_id", { :controller => "comments", :action => "update" })
  
  # DELETE
  get("/delete_comment/:path_id", { :controller => "comments", :action => "destroy" })

  #------------------------------

  # Routes for the Post resource:

  # CREATE
  post("/insert_post", { :controller => "posts", :action => "create" })
          
  # READ
  get("/posts", { :controller => "posts", :action => "index" })
  
  get("/posts/:path_id", { :controller => "posts", :action => "show" })
  
  # UPDATE
  
  post("/modify_post/:path_id", { :controller => "posts", :action => "update" })
  
  # DELETE
  get("/delete_post/:path_id", { :controller => "posts", :action => "destroy" })

  #------------------------------
  
end
