# db/seeds.rb

require 'open-uri'
require 'json'

puts "Clearing old data..."
Movie.destroy_all

puts "Seeding static movies..."

static_movies = [
  {
    title: "Wonder Woman 1984",
    overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s.",
    poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
    rating: 6.9
  },
  {
    title: "The Shawshank Redemption",
    overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison.",
    poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
    rating: 8.7
  },
  {
    title: "Titanic",
    overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.",
    poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
    rating: 7.9
  },
  {
    title: "Ocean's Eight",
    overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.",
    poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg",
    rating: 7.0
  }
]

static_movies.each do |movie_data|
  Movie.create!(movie_data)
end

puts "Static movies seeded!"

# Seed dynamique avec l'API TMDB
puts "Fetching and seeding movies from TMDB..."

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)["results"]

movies.each do |movie_data|
  # Vérifie si un film avec le même titre existe déjà
  unless Movie.exists?(title: movie_data["title"])
    Movie.create!(
      title: movie_data["title"],
      overview: movie_data["overview"],
      poster_url: "https://image.tmdb.org/t/p/original#{movie_data['poster_path']}",
      rating: movie_data["vote_average"]
    )
  end
end

puts "Movies from TMDB seeded successfully!"
