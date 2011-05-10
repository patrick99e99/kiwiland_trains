module TripsHelper
  
  def trip_stops_condition_options
    options_for_select([["exactly", "exact"], ["a maximum of", "max"]], params[:condition])
  end
  
  def trip_stops_options
    options_for_select(Array(1..30), params[:stops].to_i)
  end
  
  def distance_options
    options_for_select(Array(1..100), params[:distance].to_i)
  end
    
  def filter_options
    options_for_select(["stops", "distance"], @filter)
  end
  
  def state_hidden_fields
    [:condition, :stops, :distance, :filter].map do |param|
      # skip the id so that it does not conflict with the real form inputs
      hidden_field_tag param, params[param], :id => nil
    end
  end

end
