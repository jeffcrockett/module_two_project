Rails.application.routes.draw do
  resources :notes
  resources :lines
  resources :songs
  resources :albums
  resources :artists
  resources :analytics, only: :index
  post '/search', to: 'artists#search'
  post '/seed', to: 'artists#seed'
  root 'welcome#home'
  resources :users, only: [:new, :create, :show]
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  get 'ordered_by_albums' => 'analytics#ordered_by_albums' 
  get 'ordered_by_songs' => 'analytics#ordered_by_songs' 
  get 'ordered_by_lyrics' => 'analytics#ordered_by_lyrics' 
  get 'ordered_by_vocabulary_score' => 'analytics#ordered_by_vocabulary_score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
