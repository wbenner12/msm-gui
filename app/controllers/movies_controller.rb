class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    # Parameters: {"title"=>"1", "year"=>"2", "description"=>"3", "duration"=>"4", "image"=>"5", "director_id"=>"6"}
    m = Movie.new
    m.title = params.fetch("title")
    m.year = params.fetch("year")
    m.description = params.fetch("description")
    m.duration = params.fetch("duration")
    m.image = params.fetch("image")
    m.director_id = params.fetch("director_id")
    m.save

    redirect_to("/movies")
  end

  def destroy
    movie_id = params.fetch("an_id")
    matching_record = Movie.where({:id => movie_id})
    the_movie = matching_record.at(0)
    the_movie.destroy
    
    redirect_to("/movies")
  end

  def update
    # Parameters: {"title"=>"1", "year"=>"2", "description"=>"3", "duration"=>"4", "image"=>"5", "director_id"=>"6"}
    m_id = params.fetch("an_id")

    m = Movie.where(:id => m_id).at(0)
    m.title = params.fetch("title")
    m.year = params.fetch("year")
    m.description = params.fetch("description")
    m.duration = params.fetch("duration")
    m.image = params.fetch("image")
    m.director_id = params.fetch("director_id")

    m.save

    redirect_to("/movies/#{m.id}")
  end

end
