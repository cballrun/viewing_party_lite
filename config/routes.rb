Rails.application.routes.draw do

  root to: 'landing#index'
 
  get '/register', to: 'users#register'
  get 'users/:id/discover', to: 'users#discover'
  get '/users/:user_id/movies/:movie_id', to: 'user_movies#show' #namespace?
  get "/users/:user_id/movies/:movie_id/viewing-party/new", to: 'parties#new'
  
  resources :users, only: [:create, :show] 



end
