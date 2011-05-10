class TripsController < ApplicationController

  def index    
    @filter = params[:filter]
  end
  
  def create
    @trips = Route.new(params).find_trips
  end

end
