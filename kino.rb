require "rubygems"
require "bundler/setup"
require "sinatra"
require "sqlite3"

set :environment, :production
set :server, %w[thin]
set :port, 9494

get '/' do
  @sched = {}
  db = SQLite3::Database.new("Bishkek_Movie_Schedule_Builder/movie.sqlite3")
  theaters = db.execute("SELECT DISTINCT theaterName FROM timeTable WHERE movieDate='2013-02-11'")
  time = Time.now.strftime("%H:%M")
  date = Time.now.strftime("%Y-%m-%d")
  theaters.each do |t|
    movies = db.execute("
      SELECT movieName, movieTime, moviePrice, movieHall 
      FROM timeTable 
      WHERE 
        movieDate='#{date}' AND 
        movieTime >= '#{time}' AND
        theaterName='#{t}'
      ORDER BY movieTime ASC
      ")
    @sched[t] = movies
  end
  erb :home
end
