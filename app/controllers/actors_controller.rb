class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    a = Actor.new
    a.name = params.fetch("name")
    a.dob = params.fetch("dob")
    a.bio = params.fetch("bio")
    a.image = params.fetch("image")
    a.save

    redirect_to("/actors")
  end

  def update
    a_id = params.fetch("an_id")
    a = Actor.where({:id => a_id}).at(0)
    a.name = params.fetch("name")
    a.dob = params.fetch("dob")
    a.bio = params.fetch("bio")
    a.image = params.fetch("image")
    a.save

    redirect_to("/actors/#{a.id}")
  end

  def destroy
    a_id = params.fetch("an_id")
    a = Actor.where({:id => a_id}).at(0)
    a.destroy

    redirect_to("/actors")
  end

end
