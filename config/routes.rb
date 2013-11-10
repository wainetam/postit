PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, param: :id as :title, except: [:destroy] do
    resources :comments, only: [:create, :new]
  end
  resources :categories, param: :name, except: [:destroy, :edit, :update, :index]
  # add param: :name, -- can sort :name vs :id
  # get '/categories/new', to: 'categories#new'
  # post '/categories/new', to: 'categories#create'
  # get '/categories/:name', to: 'categories#show'
end
