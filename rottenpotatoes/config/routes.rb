# frozen_string_literal: true

Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root to: redirect('/movies')
  match 'movies/show_by_director/:id', to: 'movies#show_by_director', via: :get, as: 'show_by_director'
  match 'movies/sort_by_rating/:id', to: 'movies#sort_by_rating', via: :get, as: 'sort_by_rating'
end
