require "rubygems"
require "bundler/setup"
require "sinatra"
require "sqlite3"

set :server, %w[webrick]
set :port, 9494

get '/' do
  db = SQLite3::Database.new("Bishkek_Movie_Schedule_Builder/movie.sqlite3")
  time = Time.now.strftime("%H:%M")
  date = Time.now.strftime("%Y-%m-%d")
  puts db.inspect
  @movies = db.execute("
    SELECT theaterName, movieName, movieTime, moviePrice, movieHall
    FROM timeTable
    WHERE
      movieDate='#{date}' AND
      movieTime >= '#{time}'
    ORDER BY movieTime ASC")
  erb :home
end
