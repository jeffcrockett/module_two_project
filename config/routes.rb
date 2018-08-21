Rails.application.routes.draw do
  resources :notes
  resources :lines
  resources :songs
  resources :albums
  resources :artists
  post 'search', to: 'artists#search'
  post 'seed', to: 'artists#seed'
  root 'welcome#home'
  resources :users, only: [:new, :create, :show]
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
