
////////////////////////////////////////////////////////////////////////////////////////////
// -- Address_Parser: Contains three functions: FindAddr, GetState, & GetCity.  
// -- Function#1:
//		FindAddr(string	pAddr2Parse)
// 			Parameters:
// 			--pAddr2Parse		-- Contains the City and/or State and/or Zip OR State and/or Zip
//
// -- Function#2:
// 		GetState(string	pCityState,Boolean pStateOnly=FALSE)
// 			Parameters:
// 			--pCityState		-- Contains the City and/or State and/or Zip OR State
// 			--pStateOnly		-- A flag that indicates if only the State Name is being provided
//												 Note:  No harm occurs if the State Code is used as input.
// -- Function#3:
// 		GetCity(string	pCityState, string pStateName)
// 			Parameters:
// 			--pCityState		-- Contains the City and/or State and/or Zip OR State
// 			--pStateName		-- The State Name or State Code (based upon what exists in the data).
//
////////////////////////////////////////////////////////////////////////////////////////////

import Address, Lib_stringlib, Lib_Word, Ut;

export Address_Parser := module
	export StateNameTable	:=	[	'ALABAMA',							'ALASKA',					'AMERICAN SAMOA',	
															'ARIZONA',							'ARKANSAS',				'CALIFORNIA',			
															'PANAMA CANAL ZONE',		'COLORADO',				'CONNECTICUT',		
															'DISTRICT OF COLUMBIA',	'DELAWARE',				'FLORIDA',	
															'GEORGIA',							'GUAM',						'HAWAII',				
															'IDAHO',								'ILLINOIS',				'INDIANA',
															'IOWA',									'KANSAS',					'KENTUCKY',
															'LOUISIANA',						'MAINE',					'MARYLAND',				
															'MASSACHUSETTS',				'MICHIGAN',				'MINNESOTA',			
															'MISSISSIPPI',					'MISSOURI',				'MONTANA',	
															'NEBRASKA',							'NEVADA',					'NEW HAMPSHIRE',	
															'NEW JERSEY',						'NEW MEXICO',			'NEW YORK',		
															'NORTH CAROLINA',				'NORTH DAKOTA',		'OHIO',	
															'OKLAHOMA',							'OREGON',					'PENNSYLVANIA',
															'PUERTO RICO',					'RHODE ISLAND',		'SOUTH CAROLINA',	
															'TENNESSEE',						'SOUTH DAKOTA',		'UTAH',						
															'TEXAS',								'VIRGINIA',				'VERMONT',				
															'WASHINGTON',						'VIRGIN ISLANDS',	'WISCONSIN',
															'WEST VIRGINIA',				'ILL'];
															
	export StateAbbrTable	:=	[	'AL',	'AK',	'AZ', 'AR', 'CA', 'PR', 'CO', 'CT', 'DC',	'DE',	'FL',	
															'GA',	'HI',	'ID',	'IL',	'IN', 'IA',	'KS',	'KY', 'LA',	'ME',	'MD',
															'MA',	'MI',	'MN', 'MS', 'MO',	'MT',	'NE',	'NV',	'NH',	'NJ',	'NM',	
															'NY',	'NC',	'ND',	'OH', 'OK',	'OR',	'PA',	'PR',	'RI',	'SC',	'TN',
															'SD',	'UT',	'TX',	'VA',	'VT',	'WA',	'VI',	'WI',	'WV'];															

	export GetState(string	pCityState,Boolean pStateOnly=FALSE) := function	 
			////////////////////////////////////////////////////////////////////////////////////////////
			// -- Parameters:
			// -- pCityState -- can contain either both City & State data OR only the State name
			// -- pStateOnly -- Set to TRUE if only the State Name is being provided
			//Note:  When only the state name is being provided the user is looking for the State
			//       Code to be returned.
			////////////////////////////////////////////////////////////////////////////////////////////
			
			
			// Split the city state data into words. This will allow us to compare state data to a state full name 
			// table & also to a state abbreviation table and take anything not considered a state value as the
			// city.
			tmpCityState			:=	Address.WordSplit(pCityState);

			// Since some states are multi words (i.e. New York, we need to pull off the last two words 
			// in the city state data.
			string LastWord		:=	If(pStateOnly,
															 LIB_Word.StripUpToWord( pCityState , Count(tmpCityState)-0),
															 LIB_Word.StripUpToWord( pCityState , Count(tmpCityState)-1)
															 );	
			string Second2Last:=	If(pStateOnly,
															 LIB_Word.StripUpToWord( pCityState , Count(tmpCityState)-1),
															 LIB_Word.StripUpToWord( pCityState , Count(tmpCityState)-2)
															 );

			// Check for the last two words being in the state tables first. The reason is because we
			// of Virginia & West Virginia. If we compared the last word first, we would convert 
			// all west virginia values to virginia & include west as part of the city. No harm is done 
			// looking for "DAYTON OHIO" since the default is to go with the last word if the last two
			// words are not in the state tables. 
			tmpStateName			:=	if (LastWord = '' and Second2Last = '',
																	if (pCityState in StateNameTable or pCityState in StateAbbrTable,
																				pCityState,
																				''
																			),
																	if (Second2Last in StateNameTable, 
																				Second2Last,
																				LastWord
																			)
																);

			// Convert the State Name to the State Code.		
			StateOnly			:=	MAP(	tmpStateName = 'ALABAMA'						 => 'AL', tmpStateName = 'ALASKA'	    	=> 'AK',
																	tmpStateName = 'AMERICAN SAMOA'      => 'AS', tmpStateName = 'ARIZONA'    	=> 'AZ',
																	tmpStateName = 'ARKANSAS'            => 'AR', tmpStateName = 'CALIFORNIA' 	=> 'CA',
																	tmpStateName = 'PANAMA CANAL ZONE'   => 'CZ', tmpStateName = 'COLORADO'   	=> 'CO',
																	tmpStateName = 'CONNECTICUT'         => 'CT', tmpStateName = 'DELAWARE'  	 	=> 'DE',
																	tmpStateName = 'DISTRICT OF COLUMBIA'=> 'DC', tmpStateName = 'FLORIDA'   	 	=> 'FL',
																	tmpStateName = 'GEORGIA'             => 'GA', tmpStateName = 'GUAM'	     	 	=> 'GU',
																	tmpStateName = 'HAWAII'              => 'HI', tmpStateName = 'IDAHO'	   	 	=> 'ID',
																	tmpStateName = 'ILLINOIS'            => 'IL', tmpStateName = 'INDIANA'    	=> 'IN',
																	tmpStateName = 'IOWA'                => 'IA', tmpStateName = 'KANSAS'	    	=> 'KS',
																	tmpStateName = 'KENTUCKY'            => 'KY', tmpStateName = 'LOUISIANA'  	=> 'LA',
																	tmpStateName = 'MAINE'               => 'ME', tmpStateName = 'MARYLAND'   	=> 'MD',
																	tmpStateName = 'MASSACHUSETTS'       => 'MA', tmpStateName = 'MICHIGAN'   	=> 'MI',
																	tmpStateName = 'MINNESOTA'           => 'MN', tmpStateName = 'MISSISSIPPI'	=> 'MS',
																	tmpStateName = 'MISSOURI'            => 'MO', tmpStateName = 'MONTANA'    	=> 'MT',
																	tmpStateName = 'NEBRASKA'            => 'NE', tmpStateName = 'NEVADA'	   	 	=> 'NV',
																	tmpStateName = 'NEW HAMPSHIRE'       => 'NH', tmpStateName = 'NEW JERSEY' 	=> 'NJ',
																	tmpStateName = 'NEW MEXICO'          => 'NM', tmpStateName = 'NEW YORK'   	=> 'NY',
																	tmpStateName = 'NORTH CAROLINA'      => 'NC', tmpStateName = 'NORTH DAKOTA' => 'ND',
																	tmpStateName = 'OHIO'                => 'OH', tmpStateName = 'OKLAHOMA'     => 'OK',                                                                                                 
																	tmpStateName = 'OREGON'              => 'OR', tmpStateName = 'PENNSYLVANIA' => 'PA', 
																	tmpStateName = 'PUERTO RICO'         => 'PR', tmpStateName = 'RHODE ISLAND' => 'RI',
																	tmpStateName = 'SOUTH CAROLINA'      => 'SC', tmpStateName = 'TENNESSEE'    => 'TN',
																	tmpStateName = 'SOUTH DAKOTA'        => 'SD', tmpStateName = 'UTAH'	       	=> 'UT',
																	tmpStateName = 'TEXAS'               => 'TX', tmpStateName = 'VIRGINIA'	   	=> 'VA',
																	tmpStateName = 'VERMONT'             => 'VT', tmpStateName = 'WASHINGTON'	 	=> 'WA',
																	tmpStateName = 'VIRGIN ISLANDS'      => 'VI', tmpStateName = 'WISCONSIN'	 	=> 'WI',
																	tmpStateName = 'WEST VIRGINIA'       => 'WV', tmpStateName = 'WYOMING'	   	=> 'WY',
																	tmpStateName = 'ILL'								 => 'IL',
																	tmpStateName);

			return trim(StateOnly,left,right);
	end;  //End GetState
	
	export GetCity(string	pCityState, string pStateName) := function	
			// since it is possible that we only have a city value with no state data, resulting in LastWord &
			// second2Last being blank, we test for that condition prior to extracting city from state.
			CityOnly				:=	if (pStateName != '',
															pCityState[1..StringLib.StringFind(pCityState, pStateName, 1)-1],
															pCityState
															);
			// If the state data is a full name, it will get mapped to the abbreviation, otherwise it will default to 
			// the abbreviation.

 		 return trim(CityOnly,left,right);
	end;  //End GetCity
	
	export FindAddr(string	pAddr2Parse) := function
															
			// extract numeric zip, keeping only first 5 digits
			extractZip				:=	StringLib.StringFilter(pAddr2Parse,'-0123456789')[1..5];
			// determine if zip is digits; if not, a bad zip exists and a blank zip will be returned
			tmpZip						:=	If(StringLib.StringFind(extractZip,'-',1) = 0,extractZip,'');
			Zip								:=  trim(tmpZip,left,right);
		
			// extract alpha data (i.e. city & state data), removing extra spacing & setting to uppercase		
			tmpCleanCityState	:=	stringlib.StringToUppercase(StringLib.StringCleanSpaces(lib_stringlib.StringLib.StringFilter(pAddr2Parse,',ABCDEFGHIJKLMNOPQRSTUVWXYZ ')));
			
			//determine if a comma exists between the city and state
			CommaLoc := StringLib.StringFind(tmpCleanCityState,',',1);
			// if a comma exists, extract the state after the comma, otherwise call function GetState
			StateName			:=	If(CommaLoc > 0,GetState(tmpCleanCityState[CommaLoc+1..],TRUE),GetState(tmpCleanCityState,FALSE));
			// if a comma exists, extract the city up to the comma, otherwise call function GetCity
			CityName			:=	If(CommaLoc > 0,tmpCleanCityState[1..CommaLoc-1],GetCity(tmpCleanCityState,StateName));
			returnAddr := If (CityName = '',
												StateName + ' ' + Zip,
												CityName + ', ' + StateName + ' ' + Zip
												);
			return StringLib.StringCleanSpaces(returnAddr);
	end;  //End FindAddr
		
end; //End Address_Parser