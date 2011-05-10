class DistancesController < ApplicationController
  
  def index
    @node_count = params[:node_count].to_i
    @node_count = 2 if @node_count < 2
  end

  def create
    @route, @distance = Route.new(params).calculate_distance
  end
  
end
