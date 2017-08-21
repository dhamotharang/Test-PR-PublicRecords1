IMPORT corp2_raw_ak, corp2;

EXPORT Functions := Module
			 
	 EXPORT GetHomeState_CD(string code)
		     := case(corp2.t2u(code),	      
				//US States
				'ALABAMA'							 =>'AL',
				'ALASKA'							 =>'AK',
				'ARIZONA'							 =>'AZ',
				'ARKANSAS'						 =>'AR',
				'CALIFORNIA'					 =>'CA',
				'COLORADO'						 =>'CO',
				'CONNECTICUT'					 =>'CT',
				'DELAWARE'						 =>'DE',
				'DISTRICT OF COLUMBIA' =>'DC',
				'FLORIDA'							 =>'FL',
				'GEORGIA'							 =>'GA',
				'HAWAII'							 =>'HI',
				'IDAHO'								 =>'ID',
				'ILLINOIS'						 =>'IL',
				'INDIANA'							 =>'IN',
				'IOWA'								 =>'IA',
				'KANSAS'							 =>'KS',
				'KENTUCKY'						 =>'KY',
				'LOUISIANA'						 =>'LA',
				'MAINE'								 =>'ME',
				'MARYLAND'						 =>'MD',
				'MASSACHUSETTS'				 =>'MA',
				'MICHIGAN'						 =>'MI',
				'MINNESOTA'						 =>'MN',
				'MISSISSIPPI'					 =>'MS',
				'MISSOURI'						 =>'MO',
				'MONTANA'							 =>'MT',
				'NEBRASKA'						 =>'NE',
				'NEVADA'							 =>'NV',
				'NEW HAMPSHIRE'				 =>'NH',
				'NEW JERSEY'					 =>'NJ',
				'NEW MEXICO'					 =>'NM',
				'NEW YORK'						 =>'NY',
				'NORTH CAROLINA'			 =>'NC',
				'NORTH DAKOTA'				 =>'ND',
				'OHIO'								 =>'OH',
				'OKLAHOMA'						 =>'OK',
				'OREGON'							 =>'OR',
				'PENNSYLVANIA'				 =>'PA',
				'RHODE ISLAND'				 =>'RI',
				'SOUTH CAROLINA'			 =>'SC',
				'SOUTH DAKOTA'				 =>'SD',
				'TENNESSEE'						 =>'TN',
				'TEXAS'								 =>'TX',
				'UTAH'								 =>'UT',
				'VERMONT'							 =>'VT',
				'VIRGINIA'						 =>'VA',
				'WASHINGTON'					 =>'WA',
				'WEST VIRGINIA'				 =>'WV',
				'WISCONSIN'						 =>'WI',
				'WYOMING'						   =>'WY',
				
				//US Territories
				'AMERICAN SAMOA'                 =>'AS',
				'CANAL ZONE' 					           => 'CZ',
				'FEDERATED STATES OF MICRONESIA' =>'FM',
				'GUAM'                           =>'GU',
				'MARSHALL ISLANDS'		           =>'MH',
				'NORTHERN MARINA ISLANDS'        =>'MP',
				'NORTHERN MARIANA ISLANDS'       =>'MP',
				'PALAU' 							           =>'PW',
				'PUERTO RICO'                    =>'PR',
				'VIRGIN ISLANDS'                 =>'VI',
				'VIRGIN ISLANDS (U.S.)'          =>'VI',
				
				//Armed Forces
				'ARMED FORCES EUROPE, MIDDLE EAST, AFRICA, AND CANADA'=>'AE',
				'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA'     =>'AE',
				'ARMED FORCES PACIFIC'                                =>'AP',
				'ARMED FORCES AMERICAS EXCEPT CANADA'                 =>'AA',
				'ARMED FORCES AMERICAS, EXCLUDING CANADA'             =>'AA',
				
				//Canadian Provinces
				'ALBERTA'							      =>'AB',
				'BRITISH COLUMBIA'	 	      =>'BC',
				'MANITOBA'	 					      =>'MB',
				'NEW BRUNSWICK'	 			      =>'NB',
				'NEWFOUNDLAND AND LABRADOR'	=>'NL',
				'NORTHWEST TERRITORIES'     =>'NT',
				'NOVA SCOTIA'	 				      =>'NS',
				'NUNAVUT'							      =>'NU',
				'ONTARIO'	 						      =>'ON',
				'PRINCE EDWARD ISLAND'      =>'PE',
				'QUEBEC'	 						      =>'QC',
				'SASKATCHEWAN'	 			      =>'SK',
				'YUKON TERRITORY'			      =>'YT',
				''                          =>'',
				'**');
END;