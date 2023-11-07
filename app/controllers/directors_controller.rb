class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    d = Director.new
    d.name = params.fetch("name")
    d.dob = params.fetch("dob")
    d.bio = params.fetch("bio")
    d.image = params.fetch("image")
    d.save

    redirect_to("/directors")
  end

  def update
    d_id = params.fetch("an_id")
    d = Director.where(:id => d_id).at(0)
    d.name = params.fetch("name")
    d.dob = params.fetch("dob")
    d.bio = params.fetch("bio")
    d.image = params.fetch("image")
    d.save

    redirect_to("/directors/#{d.id}")
  end

  def destroy
    d_id = params.fetch("an_id")
    matching_record = Director.where({:id => d_id})
    the_director = matching_record.at(0)
    the_director.destroy
    redirect_to("/directors")
  end

end
