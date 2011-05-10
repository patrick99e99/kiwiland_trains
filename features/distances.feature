Feature:
	In order for kiwiland trains customers to receive information about routes
	As a user
	I want to get the total distance for a trip

		Background:
			Given I am on the distance calculator page
			Then I should see "Town 1"
			And I should see "Town 2"
			But I should not see "Town 3"
			
		Scenario: adding nodes
			When I follow "add_node_button"
			Then I should see "Town 3"
			
		Scenario: removing nodes
			When I follow "add_node_button"
			And I follow "[x]"
			Then I should not see "Town 3"
			
		Scenario Outline: calculating distances
			When I select "<town 1>" from "town_0"
			And I select "<town 2>" from "town_1"
			And I press "Calculate!"
			Then I should see "<output>"
		
			Examples:
				| town 1 | town 2 | output 		  |
				| A		 | B	  | 5	  		  |
				| C	  	 | A	  | No such route |