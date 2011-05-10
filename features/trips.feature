Feature:
	In order for kiwiland trains customers to receive information about routes
	As a user
	I want to get the number of trips between two towns with a specified number of stops
	
	Background:
		Given I am on the trips page
		Then I should not see "Find trips!"
		
	Scenario Outline: selecting a filter
		When I select "<option>" from "filter"
		And I press "Go!"
		Then I should see "<select label>"
	
		Examples:
		| option   | select label 		|
		| stops    | Stop(s)			|
		| distance | With a distance of |

	Scenario Outline: getting the number of trips by stops
		When I select "<filter>" from "filter"
		And I press "Go!"
		And I select "<start_town>" from "start_town"
		And I select "<end_town>" from "end_town"
		And I select "<condition>" from "condition"
		And I select "<stops>" from "stops"
		And I press "Find Trips!"
		Then I should see "<message>"

		Examples:
			| filter   | start_town  | end_town | condition    | stops | message		 |
			| stops    | C			 | C		| a maximum of | 3 	   | 2 trips 		 |
			| stops	   | A			 | C	    | exactly 	   | 4 	   | 3 trips 		 |
			| stops    | A			 | A	    | exactly 	   | 1	   | No trips found! |
	
	Scenario: getting the number of trips by maximum distance
		When I select "distance" from "filter"
		And I press "Go!"
		And I select "C" from "start_town"
		And I select "C" from "end_town"
		And I select "30" from "distance"
		And I press "Find trips!"
		Then I should see "7 trips"