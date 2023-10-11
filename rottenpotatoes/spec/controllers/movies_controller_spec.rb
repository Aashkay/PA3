# frozen_string_literal: true

# true
require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before do
    Movie.destroy_all

    Movie.create(title: 'Big Hero 6',
                 rating: 'PG',
                 release_date: '2014-11-07',
                 director: 'Don Hall, Chris Williams')

    # TODO(student): add more movies to use for testing
    Movie.create(title: 'Moana',
                 rating: 'R',
                 director: 'Aashay ')

    Movie.create(title: 'Nemo',
                 rating: 'PG')

    Movie.create(title: 'Lion King',
                 director: 'Aashay')

    Movie.create(title: 'IT',
                 rating: 'PG',
                 director: 'Aashay')
  end

  describe 'when trying to find movies by the same director' do
    it 'returns a valid collection when a valid director is present' do
      movie = Movie.find_by(title: 'Moana')
      get :show_by_director, params: { id: movie.id }
      expect(assigns(:movies)).to eq Movie.where(director: movie.director)
    end

    it ' when no director is present' do
      movie = Movie.find_by(title: 'Nemo')
      get :show_by_director, params: { id: movie.id }
      expect(flash[:warning]).to match(/'#{movie.title}' has no director info/)
    end
  end

  describe 'when trying to find movies with the same rating' do
    it 'returns a valid collection when multiple movies have same rating' do
      movie = Movie.find_by(title: 'Moana')
      get :sort_by_rating, params: { id: movie.id }
      expect(assigns(:movies)).to eq Movie.where(rating: movie.rating)
    end

    it 'redirects to index with a warning when no rating is present' do
      movie = Movie.find_by(title: 'Lion King')
      get :sort_by_rating, params: { id: movie.id }
      expect(response).to redirect_to(movies_path)
      # expect(flash[:warning]).to match(/'#{movie.title}' has no rating/)
    end
  end

  describe 'creates' do
    it 'valid parameters' do
      get :create, params: { movie: { title: 'Toucan Play This Game', director: 'Armando Fox',
                                      rating: 'G', release_date: '2017-07-20' } }
      expect(flash[:notice]).to match(/Toucan Play This Game was successfully created./)
      Movie.find_by(title: 'Toucan Play This Game').destroy
    end
  end

  describe 'updates' do
    it 'flashes a notice' do
      movie = Movie.create(title: 'Outfoxed!', director: 'Nick Mecklenburg',
                           rating: 'PG-13', release_date: '2023-12-17')
      get :update, params: { id: movie.id, movie: { description: 'Critics rave about this epic new thriller.' } }
      expect(flash[:notice]).to match(/Outfoxed! was successfully updated./)
      movie.destroy
    end

    it 'actually does the update' do
      movie = Movie.create(title: 'Outfoxed!', director: 'Nick Mecklenburg',
                           rating: 'PG-13', release_date: '2023-12-17')
      get :update, params: { id: movie.id, movie: { director: 'Not Nick!' } }

      expect(assigns(:movie).director).to eq('Not Nick!')
      movie.destroy
    end
  end

  describe 'deletes' do
    it 'actually deletes the movie from the db' do
      movie = Movie.find_by(title: 'IT')
      post :destroy, params: { id: movie.id }
      expect(flash[:notice]).to match(/Movie 'IT' deleted./)
    end
  end
end
