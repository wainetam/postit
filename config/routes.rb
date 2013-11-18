PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, param: :id, except: [:destroy] do
    resources :comments, only: [:create, :new]
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
