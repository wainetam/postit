PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, param: :id, except: [:destroy] do
    member do
      post :vote # expose route to every member of resource
      # post :downvote # expose route to every member of resource
    end
    resources :comments, only: [:create, :new] do
      member do
        post :vote
      end
    end
  end
  resources :categories, param: :name, except: [:destroy, :edit, :update, :index]
  resources :users, only: [:new, :create, :show, :update, :edit]
  resources :sessions, only: [:new, :create, :destroy]

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  # add param: :name, -- can sort :name vs :id
  # get '/categories/new', to: 'categories#new'
  # post '/categories/new', to: 'categories#create'
  # get '/categories/:name', to: 'categories#show'
end
