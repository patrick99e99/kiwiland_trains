require 'spec_helper'

describe Route do

  context "distance calculator" do

    def route
      Route.new(@town_data)
    end
        
    it "should extract the towns from the hash in the correct order" do
     
      @town_data = {"town_2" => 'B', "town_3" => "C", "town_1" => "A"}
      
      route.extract_towns.should == ['A', 'B', 'C']
    end
      
    it "should calculate the distance between towns and return the route and the distance" do
       @town_data = {:town_1 => "A", :town_2 => "E", :town_3 => "B", :town_4 => "C", :town_5 => "D"}
       route.calculate_distance.should == [['A', 'E', 'B', 'C', 'D'], 22]
     end
    
    it "should return nil when a route does not exist" do
      @town_data = {:town_1 => "A", :town_2 => "E", :town_3 => "D"}
        
      route.calculate_distance.should == nil
    end

    it "should convert a standard array into a nested array in groups of two" do
      # the "in_groups_of_two" method was added to class Array in lib/array_methods.rb
      [1,2,3].in_groups_of_two.should == [[1,2], [2,3]]
    end
    
  end
  
  context "trip counter" do
    
    def normalize(trip_data)
      trip_data.map {|route| route.join }
    end
    
    def find_trips
      normalize(Route.new(@trip_data).find_trips)
    end
    
    it "should find the end towns and their distances" do
      Route.end_towns("A").should == {'B' => 5, 'D' => 5, 'E' => 7}
    end
     
    it "should find the number of trips with a maximum number of stops" do
      @trip_data = {:start_town => "c", :end_town => "c", :stops => 3, :condition => :max}
      find_trips.should == ["CDC", "CEBC"]
    end
    
    it "should find the number of trips with an exact number of stops" do
      @trip_data = {:start_town => "a", :end_town => "c", :stops => 4, :condition => :exact}
      find_trips.should == ["ABCDC", "ADCDC", "ADEBC"]
    end
    
    it "should find the number of trips under a certain distance" do
      @trip_data = {:start_town => "c", :end_town => "c", :distance => 30}
      find_trips.should == ["CDC", "CDCEBC", "CDEBC", "CEBC", "CEBCDC", "CEBCEBC", "CEBCEBCEBC"]
    end
    
    it "should return a blank array when no trips can be found" do
      @trip_data = {:start_town => "A", :end_town => "A", :distance => 30}
      find_trips.should be_blank
    end
    
  end
  
  context "shortest" do
    
    it "should find the route with the shortest distance and return it in an array along with the distance" do
      trip_data = {:start_town => "B", :end_town => "B"}
      Route.new(trip_data).find_shortest.should == [9, ["B", "C", "E", "B"]]
    end
  
  end
  
end