require "rubygems"
require "bundler/setup"
require "sinatra"
require "sqlite3"
require 'json'

set :environment, :production
set :server, %w[thin]
set :port, 9494

get '/' do
  @movies = get_movies
  erb :home
end

get '/json' do
  content_type :json
  get_movies.to_json
end

def get_movies
  db = SQLite3::Database.new("Bishkek_Movie_Schedule_Builder/movie.sqlite3")
  time = Time.now.strftime("%H:%M")
  date = Time.now.strftime("%Y-%m-%d")
  puts db.inspect
  db.execute("
    SELECT theaterName, movieName, movieTime, moviePrice, movieHall
    FROM timeTable
    WHERE
      movieDate='#{date}' AND
      movieTime >= '#{time}'
    ORDER BY movieTime ASC")
end