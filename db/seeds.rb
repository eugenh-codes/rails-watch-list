# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'
require 'rest-client'
require 'faker'

url = 'https://tmdb.lewagon.com/movie/top_rated'
response = RestClient.get url
repos = JSON.parse(response)

movies = repos['results']

Movie.destroy_all
movies.each do |movie|
  m = movie.transform_keys(&:to_sym)
  rating_average = m[:vote_average].round(1)
  attributes = { title: m[:title], overview: m[:overview], poster_url: m[:poster_path], rating: rating_average }
  Movie.create!(attributes)
  # p attributes
end
# genre = Faker::Book.genre

# comment = Faker::Movie.quote
