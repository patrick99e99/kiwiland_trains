class Route

  def initialize(params)
    @start_town = params[:start_town].to_s.upcase
    @end_town = params[:end_town].to_s.upcase
    @max_distance = params[:distance].to_i
    @stops = params[:stops].to_i
    @condition = params[:condition].to_s.downcase
    @trips = []
    
    @town_data = params.select {|k,v| k.to_s.starts_with?("town") }
  end

  def self.all
    [{:start => 'A', :finish => {'B' => 5, 'D' => 5, 'E' => 7}},
     {:start => 'B', :finish => {'C' => 4}},
     {:start => 'C', :finish => {'D' => 8, 'E' => 2}},
     {:start => 'D', :finish => {'C' => 8, 'E' => 6}},
     {:start => 'E', :finish => {'B' => 3}}]
  end
  
  def self.end_towns(start_town)
    route = all.find {|d| d[:start] == start_town}
    route[:finish]
  end
  
  def self.towns
    all.map {|d| d[:start]}
  end
  
  # distance
  
  def calculate_distance
    towns = extract_towns
    # turn [:a, :b, c] into [[:a, :b], [:b, :c]]
    grouped_towns = towns.in_groups_of_two
  
    distances = grouped_towns.map do |start_town, end_town|
      route = find_route(start_town, end_town)
  
      unless route.nil?
        route[:finish][end_town]
      else
        break
      end
  
    end
  
    [towns, distances.sum] if distances
  end
  
  def find_route(start_town, end_town)
    Route.all.find {|d| d[:start] == start_town && d[:finish].include?(end_town)}
  end
  
  def extract_towns
    # turn {:town_3 => "C", :town_2 => "B", :town_1 => "A"} into ['A', 'B', 'C']
    @town_data.sort {|a,b| a.first.to_s <=> b.first.to_s}.map {|t| t.last }
  end
  
  # trips
  
  def find_trips
    @stop_traversal = lambda { stop_trips_traversal }
  
    traverse
  
    @trips.sort
  end
  
  def find_shortest
    @stop_traversal = lambda { stop_shortest_route_traversal }
  
    traverse
  
    @trips.sort {|a,b| a.keys.first <=> b.keys.first}.first.to_a.first
  end
  
  def traverse(start_town = @start_town, towns = [], total_distance = 0, stops = 0)
    towns << start_town.to_s.upcase
  
    @trip_stops = stops
    @total_distance = total_distance
    @towns = towns
  
    # ensure that a trip does not stop before it actually starts
    if @towns.length != 1 && @stop_traversal.call
      return
    end
  
   Route.end_towns(start_town).map do |town, distance|
      # duplicate the towns so each traversal has it's own unique array
      traverse(town, towns.dup, total_distance + distance, stops + 1)
    end
  end
  
  def stop_trips_traversal
    if !@condition.blank?
      trip_stops_conditions
    elsif @max_distance
      length_conditions
    end
  end
  
  def length_conditions
    process_trips if reached_destination && @total_distance < @max_distance
    
    # traversal should stop if the distance exceeds the maximum
    @total_distance >= @max_distance
  end
  
  def stop_shortest_route_traversal
    @trips << {@total_distance => @towns} if reached_destination
    # stop traversing if we reach the start town, or if any town has already been visted
    reached_destination(@start_town) || @towns.length != @towns.uniq.length
  end
  
  def trip_stops_conditions
    case @condition.to_sym
    when :exact
      if @trip_stops == @stops
        process_trips if reached_destination
      end
    when :max
      if @trip_stops <= @stops
        process_trips if reached_destination
      end
    end
  
    # traversal should stop?
    @trip_stops == @stops
  end
  
  def process_trips
    @trips << @towns
  end
  
  def reached_destination(destination = @end_town)
    @towns.last == destination
  end
  
end