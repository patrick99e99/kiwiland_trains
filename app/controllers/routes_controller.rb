class RoutesController < ApplicationController

  def index
  end
  
  def create
    @route = Route.new(params).find_shortest
  end  
  
end
