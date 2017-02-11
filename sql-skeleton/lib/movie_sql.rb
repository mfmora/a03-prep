require 'singleton'
require 'sqlite3'

class MovieDatabase < SQLite3::Database
  include Singleton

  def initialize
    super(File.dirname(__FILE__) + "/../movie.db")

    self.results_as_hash = true
    self.type_translation = true
  end

  def self.execute(*args)
    self.instance.execute(*args)
  end
end


# List the films in which 'Chuck Norris' has appeared; order by movie
# title.
def bearded_films
  MovieDatabase.execute(<<-SQL)
    SELECT
      movies.title
    FROM
      movies
    JOIN castings ON movies.id = castings.movie_id
    JOIN actors ON castings.actor_id = actors.id
    WHERE actors.name = 'Chuck Norris'
    ORDER BY movies.title
  SQL
end

# Obtain the cast list for the movie "Zombies of the Stratosphere";
# order by the actor's name.
def zombie_cast
  MovieDatabase.execute(<<-SQL)
    SELECT actors.name
    FROM actors
    JOIN castings ON actors.id = castings.actor_id
    JOIN movies ON castings.movie_id = movies.id
    WHERE movies.title = 'Zombies of the Stratosphere'
    ORDER BY actors.name
  SQL
end

# Which were the busiest years for 'Danny DeVito'? Show the year and
# the number of movies he acted in for any year in which he was part of
# >2 movies. Order by year. Note the 'V' is capitalized.
def biggest_years_for_little_danny
  MovieDatabase.execute(<<-SQL)
    SELECT movies.yr, COUNT(movies.id) AS count
    FROM movies
    JOIN castings ON movies.id = castings.movie_id
    JOIN actors ON castings.actor_id = actors.id
    WHERE actors.name = 'Danny DeVito'
    GROUP BY movies.yr
    HAVING COUNT(movies.id) > 2
  SQL
end

# List the films where 'Nicolas Cage' has appeared, but not in the
# star role. Order by movie title.
def more_cage_please
  MovieDatabase.execute(<<-SQL)
    SELECT movies.title
    FROM movies
    JOIN castings ON movies.id = castings.movie_id
    JOIN actors ON castings.actor_id = actors.id
    WHERE actors.name = 'Nicolas Cage' AND
      castings.ord != 1
    ORDER BY movies.title
  SQL
end

# List the films together with the leading star for all 1908
# films. Order by movie title.
def who_is_florence_lawrence
  MovieDatabase.execute(<<-SQL)
    SELECT movies.title, actors.name
    FROM movies
    JOIN castings ON movies.id = castings.movie_id
    JOIN actors ON castings.actor_id = actors.id
    WHERE movies.yr = 1908 AND castings.ord = 1
    ORDER BY movies.title
  SQL
end

# Some actors listed in our database are not associated with any actual
# movie role(s). How many such actors are there? Alias this number as
# 'num_bad_actors'.
def count_bad_actors
  MovieDatabase.execute(<<-SQL)
  SELECT COUNT(actors.id) as num_bad_actors
  FROM actors
  LEFT OUTER JOIN castings ON actors.id = castings.actor_id
  WHERE castings.actor_id IS NULL
SQL
end

# Obtain a list in alphabetical order of actors who've had exactly 20
# starring roles. Order by actor name.
def twenty_roles
  MovieDatabase.execute(<<-SQL)
  SQL
end

# List the film title and the leading actor for all of the films
# 'Chris Farley' played in.
def chris_is_missed
  MovieDatabase.execute(<<-SQL)
  SQL
end
