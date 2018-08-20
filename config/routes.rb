Rails.application.routes.draw do
  resources :notes
  resources :lines
  resources :songs
  resources :albums
  resources :artists
  post 'search', to: 'artists#search'
  post 'seed', to: 'artists#seed'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
