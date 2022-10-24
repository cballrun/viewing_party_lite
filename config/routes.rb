Rails.application.routes.draw do

  root to: 'landing#home'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'
  
 
  get '/register', to: 'users#register'
  get 'users/:id/discover', to: 'users#discover'
  get '/users/:user_id/movies/:movie_id', to: 'user_movies#show' #namespace?
  get "/users/:user_id/movies/:movie_id/viewing-party/new", to: 'parties#new'
  post "/users/:user_id/movies/:movie_id/viewing-party/create", to: 'parties#create'
  


  resources :users, only: [:create, :show] do #, module: 'user' 
    resources :movies, only: [:index]
  end


end
