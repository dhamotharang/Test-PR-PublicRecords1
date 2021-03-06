import ut;
EXPORT fn_st2abbrev(string state):= 
map(ut.CleanSpacesAndUpper(state) = 'ALABAMA' 							=> 'AL',
    ut.CleanSpacesAndUpper(state) = 'ALASKA' 								=> 'AK', 
    ut.CleanSpacesAndUpper(state) = 'ARKANSAS' 							=> 'AR', 
    ut.CleanSpacesAndUpper(state) = 'AMERICAN SAMOA' 				=> 'AS', 
    ut.CleanSpacesAndUpper(state) = 'ARIZONA' 							=> 'AZ', 
    ut.CleanSpacesAndUpper(state) = 'CALIFORNIA' 						=> 'CA', 
    ut.CleanSpacesAndUpper(state) = 'COLORADO' 							=> 'CO', 
    ut.CleanSpacesAndUpper(state) = 'CONNECTICUT' 					=> 'CT', 
    ut.CleanSpacesAndUpper(state) = 'DISTRICT OF COLUMBIA' 	=> 'DC', 
    ut.CleanSpacesAndUpper(state) = 'DELAWARE' 							=> 'DE', 
    ut.CleanSpacesAndUpper(state) = 'FLORIDA' 							=> 'FL', 
    ut.CleanSpacesAndUpper(state) = 'GEORGIA' 							=> 'GA', 
    ut.CleanSpacesAndUpper(state) = 'GUAM' 									=> 'GU', 
    ut.CleanSpacesAndUpper(state) = 'HAWAII' 								=> 'HI', 
    ut.CleanSpacesAndUpper(state) = 'IOWA' 									=> 'IA', 
    ut.CleanSpacesAndUpper(state) = 'IDAHO' 								=> 'ID', 
    ut.CleanSpacesAndUpper(state) = 'ILLINOIS' 							=> 'IL', 
    ut.CleanSpacesAndUpper(state) = 'INDIANA'	 							=> 'IN', 
    ut.CleanSpacesAndUpper(state) = 'KANSAS' 								=> 'KS', 
    ut.CleanSpacesAndUpper(state) = 'KENTUCKY' 							=> 'KY', 
    ut.CleanSpacesAndUpper(state) = 'LOUISIANA' 						=> 'LA', 
    ut.CleanSpacesAndUpper(state) = 'MASSACHUSETTS' 				=> 'MA', 
    ut.CleanSpacesAndUpper(state) = 'MARYLAND'							=> 'MD', 
    ut.CleanSpacesAndUpper(state) = 'MAINE' 								=> 'ME', 
    ut.CleanSpacesAndUpper(state) = 'MICHIGAN' 							=> 'MI', 
    ut.CleanSpacesAndUpper(state) = 'MINNESOTA' 						=> 'MN', 
    ut.CleanSpacesAndUpper(state) = 'MISSOURI' 							=> 'MO', 
    ut.CleanSpacesAndUpper(state) = 'MISSISSIPPI' 					=> 'MS', 
    ut.CleanSpacesAndUpper(state) = 'MONTANA' 							=> 'MT', 
    ut.CleanSpacesAndUpper(state) = 'NORTH CAROLINA' 				=> 'NC', 
    ut.CleanSpacesAndUpper(state) = 'NORTH DAKOTA' 					=> 'ND', 
    ut.CleanSpacesAndUpper(state) = 'NEBRASKA' 							=> 'NE', 
    ut.CleanSpacesAndUpper(state) = 'NEW HAMPSHIRE' 				=> 'NH', 
    ut.CleanSpacesAndUpper(state) = 'NEW JERSEY' 						=> 'NJ', 
    ut.CleanSpacesAndUpper(state) = 'NEW MEXICO' 						=> 'NM', 
    ut.CleanSpacesAndUpper(state) = 'NEVADA' 								=> 'NV', 
    ut.CleanSpacesAndUpper(state) = 'NEW YORK' 							=> 'NY', 
    ut.CleanSpacesAndUpper(state) = 'OHIO' 									=> 'OH', 
    ut.CleanSpacesAndUpper(state) = 'OKLAHOMA' 							=> 'OK', 
    ut.CleanSpacesAndUpper(state) = 'OREGON' 								=> 'OR', 
    ut.CleanSpacesAndUpper(state) = 'PENNSYLVANIA' 					=> 'PA', 
    ut.CleanSpacesAndUpper(state) = 'PUERTO RICO'						=> 'PR', 
    ut.CleanSpacesAndUpper(state) = 'RHODE ISLAND' 					=> 'RI', 
    ut.CleanSpacesAndUpper(state) = 'SOUTH CAROLINA' 				=> 'SC', 
    ut.CleanSpacesAndUpper(state) = 'SOUTH DAKOTA'		 			=> 'SD', 
    ut.CleanSpacesAndUpper(state) = 'TENNESSEE' 						=> 'TN', 
    ut.CleanSpacesAndUpper(state) = 'TEXAS' 								=> 'TX', 
		ut.CleanSpacesAndUpper(state) = 'UNITED STATES' 				=> 'US', 
    ut.CleanSpacesAndUpper(state) = 'UTAH' 									=> 'UT', 
    ut.CleanSpacesAndUpper(state) = 'VIRGINIA' 							=> 'VA', 
    ut.CleanSpacesAndUpper(state) = 'VIRGIN ISLAND'					=> 'VI',
    ut.CleanSpacesAndUpper(state) = 'VIRGIN ISLANDS' 				=> 'VI',		
    ut.CleanSpacesAndUpper(state) = 'VERMONT' 							=> 'VT', 
    ut.CleanSpacesAndUpper(state) = 'WASHINGTON' 						=> 'WA', 
    ut.CleanSpacesAndUpper(state) = 'WISCONSIN' 						=> 'WI', 
    ut.CleanSpacesAndUpper(state) = 'WEST VIRGINIA' 				=> 'WV', 
    ut.CleanSpacesAndUpper(state) = 'WYOMING' 							=> 'WY',
    ''
	 );