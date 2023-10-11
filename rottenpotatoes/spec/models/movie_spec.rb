# frozen_string_literal: true

# true
require 'rails_helper'

RSpec.describe Movie, type: :model do
  before do
    if described_class.where(title: 'Big Hero 6').empty?
      described_class.create(title: 'Big Hero 6',
                             rating: 'PG', release_date: '2014-11-07')
    end

    # TODO(student): add more movies to use for testing
    if described_class.where(title: 'a').empty?
      described_class.create(title: 'a', rating: 'R',
                             director: 'Aashay')
    end

    if described_class.where(title: 'b').empty?
      described_class.create(title: 'b', rating: 'R',
                             director: 'Aashay')
    end
    if described_class.where(title: 'c').empty?
      described_class.create(title: 'c',
                             director: 'Aashay')
    end

    described_class.create(title: 'd', rating: 'R') if described_class.where(title: 'd').empty?
  end

  describe 'others_by_same_director method' do
    it 'returns all other movies by the same director' do
      movie = described_class.find_by(title: 'b')
      expect(movie.find_same_director_movies).to include(described_class.find_by(title: 'a'))
    end

    it 'does not return movies by other directors' do
      movie = described_class.find_by(title: 'd')
      expect(movie.find_same_director_movies).to be_empty
    end
  end

  describe 'find_same_rating_movies method' do
    it 'does not return movies with same rating' do
      movie = described_class.find_by(title: 'c')
      expect(movie.find_same_rating_movies).to be_empty
    end

    it 'returns all movies with the same rating' do
      movie = described_class.find_by(title: 'a')
      expect(movie.find_same_rating_movies).to include(described_class.find_by(title: 'b'))
    end
  end
end
