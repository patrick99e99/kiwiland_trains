Feature:
	In order to extrapolate the data I am looking for
	As a user
	I want to select an option

		Scenario: visiting the home page
			Given I am on the home page
			Then I should see "Total Distance"
			And I should see "Number of Trips"
			And I should see "Shortest"
		
		Scenario Outline: Choosing an option
			Given I am on the home page
			When I follow "<link>"
			Then I should see "<header>"
			
			Examples:			
			| link 			  | header			 		 		 |

			| Total Distance  | Distance Calculator 			 |
			| Number of Trips | Find the Number of Trips 		 |
			| Shortest Route  | Shortest Route Between Two Towns |