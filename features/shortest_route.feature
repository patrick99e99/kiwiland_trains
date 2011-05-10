Feature:
	In order for kiwiland trains customers to receive information about routes
	As a user
	I want to get shortest route possible between two towns
	
	Scenario Outline:  finding the shortest route
		Given I am on the shortest route page
		When I select "<start town>" from "start_town"
		And I select "<end town>" from "end_town"
		And I press "Find shortest route!"
		Then I should see "<output>"
		
		Examples:
			| start town | end town | output 		  |
			| A			 | C		| 9				  |
			| B			 | B		| 9				  |
			| A			 | A		| No route found! |