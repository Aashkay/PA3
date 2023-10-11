# frozen_string_literal: true

# true ActiveRecord::Base
class Movie < ActiveRecord::Base
  def find_same_director_movies
    if director.blank?
      []
    else
      Movie.where(director:)
    end
  end

  def find_same_rating_movies
    if rating.blank?
      []
    else
      Movie.where(rating:)
    end
  end
end
